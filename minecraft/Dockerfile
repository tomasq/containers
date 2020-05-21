FROM centos:latest

LABEL maintainer "tomasq@gmail.com"
LABEL image "minecraft_dev"

ARG MC_VERSION=1.15.2
LABEL version=${MC_VERSION}

RUN set -x; \
dnf upgrade -y; \
dnf install -y java-1.8.0-openjdk jq curl; \
dnf clean all

VOLUME /data

WORKDIR /app

COPY server.jar minecraft_server.jar
COPY config /app/

RUN set -x; \
ln -s /data/logs /app/logs; \
ln -s /data/world /app/world; \
ln -s /data/whitelist.json /app/whitelist.json

EXPOSE 25565/tcp

ENV EULA=true

ENTRYPOINT [ "/app/minecraft.sh" ]