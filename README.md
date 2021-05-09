# docker: tor private obfs4 bridge + socks5 proxy 🐳

Tor bridge running obfs4 obfuscation protocol on Alpine

Alpine port of https://dip.torproject.org/torproject/anti-censorship/docker-obfs4-bridge

## usage

select a random `$OR_PORT` and `$PT_PORT`

(see `/proc/sys/net/ipv4/ip_local_port_range` for range)

```sh
docker run --name tor_obfs4_bridge \
    -e OR_PORT=42218 -p 42218:42218 \
    -e PT_PORT=51804 -p 51000:51000 \
    -p 9150:9150 \
    -e CONTACT_INFO=admin@optional.com \
    -v tor_obfs4_bridge_data:/var/lib/tor \
    --read-only --tmpfs /tmp:rw,size=4k
    ookangzheng/docker-tor-obfs-bridge:latest
```

add `-v tor_obfs4_bridge_data:/var/lib/tor` to keep server's identity key
when restarting the container

additionally add `--read-only --tmpfs /tmp:rw,size=4k`
to make the container's root filesystem read only

verify status of bridge at  https://metrics.torproject.org/rs.html

## Docker-compose

```
version: '3.3'
services:
    docker-tor-obfs-bridge:
        container_name: tor_obfs4_bridge
        environment:
            - OR_PORT=42218
            - PT_PORT=51804
            - CONTACT_INFO=admin@optional.com
        ports:
            - '42218:42218'
            - '51000:51000'
            - '9150:9150'
        volumes:
            - 'tor_obfs4_bridge_data:/var/lib/tor'
        tmpfs: '/tmp:rw,size=4k'
        image: 'ookangzheng/docker-tor-obfs-bridge:latest'
```

## further reading

https://community.torproject.org/relay/setup/bridge/
