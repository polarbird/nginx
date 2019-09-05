#
# Nginx Dockerfile
# version 1.1
#
FROM ubuntu:18.04
LABEL maintainer="polarbird<jlm0808@126.com>"

COPY mnt /mnt
VOLUME /mnt/acs_mnt/nas/polarbird

#Update nginx.list
COPY nginx.list /etc/apt/sources.list.d/nginx.list
COPY nginx_signing.key /root/nginx_signing.key

RUN apt-key add /root/nginx_signing.key \
    && apt-get update \
    && DEBIAN_FRONTEND="noninteractive" \
        apt-get install -y nginx \
    && rm -rf /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]

