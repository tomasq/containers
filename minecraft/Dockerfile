FROM openjdk:8-jre-alpine
LABEL maintainer="tomasq@gmail.com"

ARG BUILD_DATE
ARG MC_VERSION


ENV EULA=true

WORKDIR /app

RUN set -x; \
apk --no-cache add curl jq; \


COPY config /app/

RUN set -x; \
ln -s /data/logs /app/logs; \
ln -s /data/world /app/world; \
ln -s /data/whitelist.json /app/whitelist.json

VOLUME /data

EXPOSE 25565/tcp

ENTRYPOINT [ "/app/minecraft.sh" ]