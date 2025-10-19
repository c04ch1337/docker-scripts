#!/bin/bash
# docker-manager.sh

case "$1" in
    "up")
        docker-compose up -d
        ;;
    "down")
        docker-compose down
        ;;
    "restart")
        docker-compose restart
        ;;
    "rebuild")
        docker-compose down
        docker-compose build --no-cache
        docker-compose up -d
        ;;
    "logs")
        docker-compose logs -f
        ;;
    "status")
        docker-compose ps
        ;;
    "update")
        docker-compose pull
        docker-compose down
        docker-compose up -d
        ;;
    *)
        echo "Usage: $0 {up|down|restart|rebuild|logs|status|update}"
        exit 1
        ;;
esac
