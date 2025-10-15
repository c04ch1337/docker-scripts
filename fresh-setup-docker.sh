#!/bin/bash
### After nuking (nuke-docker.sh), set up a fresh environment ###
set -e

echo "=================================================="
echo "🆕 FRESH DOCKER SETUP"
echo "=================================================="

echo ""
echo "1. Checking Docker installation..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not installed. Installing..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    echo "✅ Docker installed. Please log out and back in, or run: newgrp docker"
    exit 0
fi

# Check if user is in docker group
if ! groups $USER | grep -q '\bdocker\b'; then
    echo "⚠️  User not in docker group. Adding..."
    sudo usermod -aG docker $USER
    echo "✅ Added to docker group. Please log out and back in, or run: newgrp docker"
    exit 0
fi

echo "✅ Docker is ready"

echo ""
echo "2. Checking Docker Compose..."
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose not installed. Installing..."
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "✅ Docker Compose installed"
fi

echo ""
echo "3. Testing Docker setup..."
docker version
docker-compose version

echo ""
echo "4. Current resource status:"
docker system df

echo ""
echo "✅ FRESH SETUP COMPLETE"
echo "=================================================="
echo "Next steps:"
echo "  1. Navigate to your project"
echo "  2. Run: docker-compose up -d"
echo "  3. Run: ./check-docker.sh (to verify)"
echo "=================================================="