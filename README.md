# Unbound-docker
run Unbound DNS in Alpine docker container.
Mainly for Raspberry Pi, but should work on any ARM64 platform.

### Building
```bash
docker build https://github.com/d3vilh/unbound-docker.git -t local/unbound
```

### Running
```bash
docker run -d -p 53:53 -p 53:53/udp --restart=unless-stopped local/unbound
```

### Running with own MAC & IP
Running unbound with its own MAC and IP address on the network, allowing to serve the physical network directly.

```bash
docker network create -d macvlan --subnet=10.0.1.0/24 --gateway=10.0.1.1 -o parent=eth0 ext_net
docker run -d --name dnsresolver01 --network=ext_net --ip=10.0.1.8 --restart=unless-stopped local/unbound
```