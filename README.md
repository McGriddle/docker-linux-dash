# docker-linux-dash

Docker container for https://github.com/afaqurk/linux-dash


## Usage

```
docker run -d --name linuxdash \
 --cap-add=NET_ADMIN \
 -p 7171:7171 \
 -e BASEURL="" \
 mcgriddle/linux-dash:latest
```

## Parameters
* `-cap-add=NET_ADMIN` - needed if you want to view your host servers networking information
* `-p 7171:7171` - the port the server listens on
* `-e BASEURL` - base url used for reverse proxy setups. must **not** have leading forward slash.


## Examples

### Just Run It

Access it on `0.0.0.0:7171`

```
docker run -d --name linuxdash \
 --cap-add=NET_ADMIN \
 -p 7171:7171 \
 -e BASEURL="" \
 mcgriddle/linux-dash:latest
```


### Reverse Proxy

If you want to use this with a reverse proxy subfolder, set the BASEURL to that folder. If I wanted to access this at `/dash`, then you'd run 

```
docker run -d --name linuxdash \
 --cap-add=NET_ADMIN \
 -e BASEURL="dash" \
 mcgriddle/linux-dash:latest
```

Supporting nginx location
```
location /dash/ {
        proxy_pass  http://<name_of_linked_container>:7171/;
        proxy_http_version 1.1;
        proxy_set_header Connection "upgrade";
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header X-Forwarded-For $remote_addr;
    }
```

**Note:** The leading forward slash is purposely removed.


### Sources

* [docker alpine base by linuxserver.io](https://github.com/linuxserver/docker-baseimage-alpine)
* [s6 overlay](https://github.com/just-containers/s6-overlay)
