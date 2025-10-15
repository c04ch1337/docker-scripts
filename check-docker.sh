#!/bin/bash
### See what's currently running ###
echo "=================================================="
echo "🔍 DOCKER ENVIRONMENT CHECK"
echo "=================================================="

echo ""
echo "🐳 DOCKER INFO:"
docker --version
docker-compose --version

echo ""
echo "📦 RUNNING CONTAINERS:"
docker ps

echo ""
echo "💤 STOPPED CONTAINERS:"
docker ps -a --filter "status=exited" --format "table {{.Names}}\t{{.Status}}\t{{.RunningFor}}"

echo ""
echo "🖼️  IMAGES:"
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}\t{{.CreatedSince}}"

echo ""
echo "💾 VOLUMES:"
docker volume ls

echo ""
echo "🌐 NETWORKS:"
docker network ls --filter type=custom

echo ""
echo "📊 RESOURCE USAGE:"
docker system df

echo ""
echo "=================================================="
echo "Quick Commands:"
echo "  ./clean-project.sh    - Clean current project"
echo "  ./nuke-docker.sh      - Nuclear reset (DANGER)"
echo "  ./setup-fresh.sh      - Fresh setup"
echo "=================================================="