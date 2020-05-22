FROM openjdk:8-jre-alpine
LABEL maintainer="tomasq@gmail.com"

ARG BUILD_DATE
ARG MC_VERSION
ARG BUILD_VERSION="1.0"

# Labels
LABEL mc_version=${MC_VERSION}

# Label Schema
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=${BUILD_DATE}
LABEL org.label-schema.version=${BUILD_VERSION}
LABEL org.label-schema.description="Minecraft Server"
LABEL org.label-schema.docker.cmd="docker run -d --rm -p \
	25565:25565 -v minecraft_data:/data minecraft"

WORKDIR /app

RUN set -x; \
  apk --no-cache add curl jq; \
  if [[ -z "$MC_VERSION" ]] || [[ "$MC_VERSION" = "latest" ]]; then \
    latest_version_url=$(curl -fsSL https://launchermeta.mojang.com/mc/game/version_manifest.json \
    | jq -r '.latest.release as $latest_release | .versions[] | select(.id == $latest_release) | .url') \
    && latest_download_url=$(curl -fsSL "$latest_version_url" | jq -r ".downloads.server.url") \
    && curl -fsSL "$latest_download_url" -o minecraft_server.jar \
    && apk --no-cache del curl jq \
  ; else \
    target_version_url=$(curl -fsSL https://launchermeta.mojang.com/mc/game/version_manifest.json \
    | jq -r --arg MC_VERSION "$MC_VERSION" '.versions[] | select(.id==$MC_VERSION) | .url') \
    && target_download_url=$(curl -fsSL "$target_version_url" | jq -r ".downloads.server.url") \
    && curl -fsSL "$target_download_url" -o minecraft_server.jar \
    && apk --no-cache del curl jq \
  ; fi 

RUN set -x; \
ln -s /data/logs /app/logs; \
ln -s /data/world /app/world; \
ln -s /data/whitelist.json /app/whitelist.json

COPY config /app/

VOLUME /data

EXPOSE 25565/tcp

ENV INIT_MEM=1G \
	MAX_MEM=4G \
	SERVER_JAR=/app/minecraft_server.jar \
	EULA=true

ENTRYPOINT java -Xms${INIT_MEM} -Xmx${MAX_MEM} -jar ${SERVER_JAR} nogui