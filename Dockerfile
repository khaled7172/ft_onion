

FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    nginx \
    tor \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/sites-available/default
COPY sshd_config /etc/ssh/sshd_config
COPY torrc /etc/tor/torrc
COPY index.html /var/www/html/index.html
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Create a test user for SSH for evaluator testing
# We disable password authentication, so they must use a key, but we'll add a 'guest' user
RUN useradd -m -s /bin/bash guest && \
    mkdir -p /home/guest/.ssh && \
    chown guest:guest /home/guest/.ssh && \
    chmod 700 /home/guest/.ssh

# Expose local ports (not strictly necessary for Tor, but good for local debugging)
EXPOSE 80 4242

ENTRYPOINT ["/entrypoint.sh"]
