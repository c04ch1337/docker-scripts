#!/bin/bash
# rebuild-docker.sh - Complete rebuild script

set -e  # Exit on any error

echo "Starting Docker rebuild process..."

# Stop and remove all containers
echo "Stopping all running containers..."
docker stop $(docker ps -aq) 2>/dev/null || true

echo "Removing all containers..."
docker rm $(docker ps -aq) 2>/dev/null || true

# Remove all images
echo "Removing all images..."
docker rmi $(docker images -q) 2>/dev/null || true

# Remove unused volumes (optional - be careful!)
# echo "Removing unused volumes..."
# docker volume prune -f

# Remove unused networks (optional)
echo "Cleaning up unused networks..."
docker network prune -f

# Rebuild and start services (if using docker-compose)
if [ -f "docker-compose.yml" ]; then
    echo "Rebuilding with docker-compose..."
    docker-compose up --build -d
else
    echo "No docker-compose.yml found. Rebuild complete."
fi

echo "Docker rebuild completed successfully!"
