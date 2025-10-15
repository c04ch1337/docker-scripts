#!/bin/bash
### Clean a specific project without nuking everything ###
set -e

echo "=================================================="
echo "🧹 PROJECT-SPECIFIC DOCKER CLEANUP"
echo "=================================================="

# Get project directory or use current
PROJECT_DIR=${1:-$(pwd)}
PROJECT_NAME=$(basename "$PROJECT_DIR")

echo "Cleaning project: $PROJECT_NAME"
echo "Directory: $PROJECT_DIR"
echo ""

# Check if docker-compose.yml exists
if [ ! -f "$PROJECT_DIR/docker-compose.yml" ]; then
    echo "❌ No docker-compose.yml found in $PROJECT_DIR"
    echo "   Either navigate to project directory or specify path:"
    echo "   ./clean-project.sh /path/to/your/project"
    exit 1
fi

cd "$PROJECT_DIR"

echo "1. Stopping and removing project containers..."
docker-compose down --remove-orphans

echo "2. Removing project images..."
docker-compose down --rmi all

echo "3. Removing project volumes..."
docker-compose down --volumes

echo "4. Removing project networks..."
docker-compose down --remove-orphans

echo "5. Removing dangling images..."
docker image prune -f

echo ""
echo "✅ PROJECT CLEANUP COMPLETE: $PROJECT_NAME"
echo "=================================================="

# Show remaining project-related resources
echo ""
echo "Remaining project resources:"
echo "Containers (project): $(docker ps -a --filter "name=${PROJECT_NAME}" -q | wc -l)"
echo "Images (project): $(docker images --filter "reference=*${PROJECT_NAME}*" -q | wc -l)"
echo "Volumes (project): $(docker volume ls --filter "name=${PROJECT_NAME}" -q | wc -l)"