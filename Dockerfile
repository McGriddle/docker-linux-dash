FROM lsiobase/alpine:3.7
MAINTAINER J
 
RUN apk update && apk add git make nodejs nodejs-npm curl bind-tools procps
RUN curl -L $(curl -s https://api.github.com/repos/afaqurk/linux-dash/releases/latest | awk '/tarball_url/ { print $2 }' | sed 's/"//g' | sed 's/,//g') | tar -xz \
&& mv afaqurk*/* app/ \
&& cd app \
&& npm install --production \
&& rm -rf /var/cache/apk/* \
&& rm -rf /root \
&& mkdir -p / /root \
&& mkdir -p /var/log/dash \
&& chown -R nobody:nobody /var/log/dash

COPY root/ /
 
EXPOSE 7171