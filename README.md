*This project was made by khhammou*

# ft_onion

A deep dive into the Tor network, hidden services, and secure server configuration for the 42 Cybersecurity Piscine.

## Overview
The goal of this project is to create an anonymous web service on the Tor network (a hidden service). The service must host a static webpage via Nginx (port 80) and provide secure SSH access (port 4242) while blocking all incoming traﬃc from the public internet.

## Features Implemented
- **Tor Hidden Service**: Automatically generates and hosts a V3 `.onion` address.
- **Nginx Web Server**: Configured to serve content strictly via localhost proxy.
- **Bonus 1 (SSH Fortification)**: Root login disabled, password authentication disabled, port changed to 4242, auth attempts strictly limited.
- **Bonus 2 (Interactive App)**: The `index.html` file features a fully interactive HTML5 Canvas "Matrix Rain" effect with a functional simulated command-line interface.

## Quickstart Testing (Docker)
We use Docker to make validation completely automated. 

```bash
make
```

### Accessing the Web Page
1. Download and open the [Tor Browser](https://www.torproject.org/).
2. Paste your `.onion` URL into the address bar.
3. Enjoy the interactive Matrix terminal!

### Accessing SSH
Because SSH is also hidden behind the Tor network, you must route your SSH command through a Tor proxy (using `torsocks` or `nc -x`).

```bash
# Example using torsocks
torsocks ssh -p 4242 guest@<your_onion_url>.onion
```
*(Note: To successfully authenticate, you must manually mount or copy your public SSH key into the `/home/guest/.ssh/authorized_keys` file inside the Docker container).*

## Clean Up
```bash
make clean
```
## Tests
make
copy .onion URL to a web browser
click terminal and try help, about, status
torsocks ssh -p 4242 root@<URL>.onion should fail
torsocks ssh -p 4242 guest@<URL>.onion to try to enter password but should be respected
docker exec -i ft_onion_service sh -c 'cat >> /home/guest/.ssh/authorized_keys' < ~/.ssh/id_rsa.pub copy machines ssh key to authorized list
torsocks ssh -p 4242 guest@<URL>.onion login
curl localhost:80 to test if it is really only locally and not available from the internet
make clean


