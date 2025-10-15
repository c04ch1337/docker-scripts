#!/bin/bash
### Quick Reset Script for Docker Projects ###
set -e

echo "🔄 QUICK PROJECT RESET"

if [ ! -f "docker-compose.yml" ]; then
    echo "❌ No docker-compose.yml in current directory"
    echo "   Navigate to project folder first"
    exit 1
fi

PROJECT_NAME=$(basename $(pwd))

echo "Project: $PROJECT_NAME"
echo ""

echo "1. Stopping project..."
docker-compose down

echo "2. Removing containers and volumes..."
docker-compose down -v --remove-orphans

echo "3. Rebuilding images..."
docker-compose build --no-cache

echo "4. Starting fresh..."
docker-compose up -d

echo "5. Checking status..."
docker-compose ps

echo ""
echo "✅ QUICK RESET COMPLETE: $PROJECT_NAME"
echo "View logs: docker-compose logs -f"