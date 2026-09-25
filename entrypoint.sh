#!/bin/bash

mkdir -p /run/sshd
chmod 0755 /run/sshd

mkdir -p /var/lib/tor/hidden_service
chown -R debian-tor:debian-tor /var/lib/tor
chmod 700 /var/lib/tor/hidden_service

service nginx start

/usr/sbin/sshd

# Start Tor in the foreground so the container stays running
echo "Starting Tor..."
exec su -s /bin/bash -c "tor -f /etc/tor/torrc" debian-tor
