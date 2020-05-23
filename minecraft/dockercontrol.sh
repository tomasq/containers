#!/usr/bin/env bash

# dockercontrol.sh - build and manage docker containers
#
# May 2020
# Tomas Quintero
# <tomasq@gmail.com>
#
# Basic script to automate build/start/stop iterations

set -e

readonly IMAGE_NAME=minecraft
readonly CONTAINER_NAME=minecraft

function build_container() {
    docker build \
    --no-cache=true \
    --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
    -t "$IMAGE_NAME:latest" \
    .
}

function start_container() {
    docker run -d -it --rm \
    --name "$CONTAINER_NAME" \
    --memory="5g" \
    --cpus="2" \
    -e TZ=America/New_York \
    -p 25565:25565 \
    -v minecraft_data:/data \
    "$IMAGE_NAME"
}

function stop_container() {
    docker stop $(docker ps -q -f "label=image=$IMAGE_NAME")
}

function status_container() {
    docker ps -f "label=image=$IMAGE_NAME"
}

case "$1" in
    start)
        start_container
        ;;

    stop)
        stop_container
        ;;

    status)
        status_container
        ;;

    build)
        build_container
        ;;

    *)
        echo $"Usage: $0 {start|stop|build}"
        exit 1
esac