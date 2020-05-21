#!/usr/bin/env bash

# dockercontrol.sh - build and manage docker containers
#
# May 2020
# Tomas Quintero
# <tomasq@gmail.com>
#
# Basic script to automate build/start/stop iterations

set -e

readonly IMAGE_NAME=minecraft_dev

function build_container() {
    docker build -t "$IMAGE_NAME" .
}

function start_container() {
    docker run -d --rm \
    --memory="5g" \
    --cpus="2" \
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