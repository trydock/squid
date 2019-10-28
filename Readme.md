# Docker SQUID 4.8 Proxy

This is Squid Cache: Version 4.8

The image is based on Alpine Linux.

## docker-compose.yml ##

```yaml
version: "3.2"
services:
  cache01:
    container_name: cache_srv01
    image: trydock/dkr-squid
    ports:
      - 3128:3128
    volumes:
      - ./conf/squid35/squid.conf:/etc/squid/squid.conf
      - ./conf/squid35/passwords:/etc/squid/passwords
    ulimits:
      nofile:
        soft: 65535
        hard: 65535
```

## conf/squid35/squid.conf ##

```
acl SSL_ports port 443
acl Safe_ports port 21
acl Safe_ports port 80
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
http_access deny !Safe_ports
acl CONNECT method CONNECT
http_access deny CONNECT !SSL_ports
cache_dir aufs /var/cache/squid 10240 16 256
maximum_object_size 5120 MB
auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwords
auth_param basic realm proxy
acl authenticated proxy_auth REQUIRED
http_access allow localhost
http_port 3128
http_access allow authenticated
http_access deny all
strip_query_terms offA
logformat docker %>a %[ui %[un [%tl] "%rm %ru HTTP/%rv" %>Hs %<st "%{Referer}>h" "%{User-Agent}>h" %Ss:%Sh
access_log daemon:/var/log/squid/access.log docker
```

## conf/squid35/passwords ##

```
admin:$apr1$UVImn..F$MUx.vBv52KIaNS12FEIsT.
```

username : admin

password : admin123
