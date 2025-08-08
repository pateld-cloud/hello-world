#!/usr/bin/env bash
set -euo pipefail

# Where repo is copied on EC2 (matching workflow target)
APP_DIR="/home/ubuntu/project/hello-world/fargate-deployment-app"

echo "Starting deploy at $(date)"

cd "$APP_DIR"

# Stop & remove previous containers (if exist)
docker ps -q --filter "name=frontend" | xargs -r docker stop || true
docker ps -q --filter "name=backend"  | xargs -r docker stop || true
docker container rm -f frontend || true
docker container rm -f backend  || true

# Build and run backend
echo "Building backend..."
cd "$APP_DIR/backend"
docker build -t backend-app:latest .

echo "Running backend (8000)..."
docker run -d --name backend \
  --restart unless-stopped \
  -p 8000:8000 \
  backend-app:latest

# Build and run frontend
echo "Building frontend..."
cd "$APP_DIR/frontend"
docker build -t frontend-app:latest .

echo "Running frontend (80)..."
docker run -d --name frontend \
  --restart unless-stopped \
  -p 80:80 \
  frontend-app:latest

echo "Deployment finished at $(date)"

