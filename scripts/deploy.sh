#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Load environment v
echo "Checking compose config..."
docker compose config

# Build images
echo "Building images..."
docker compose build

# Push to Docker Hub
echo "Logging into Docker Hub..."
echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin

# Tag and push images 
echo "Tagging images..."
docker tag aircraft_backend:latest $DOCKERHUB_USERNAME/aircraft_backend:latest
docker tag aircraft_frontend:latest $DOCKERHUB_USERNAME/aircraft_frontend:latest

# Push images to Docker Hub repository 
echo "Pushing images..."
docker push $DOCKERHUB_USERNAME/aircraft_backend:latest
docker push $DOCKERHUB_USERNAME/aircraft_frontend:latest

# Deploy updated containers
echo "Deploying..."
docker compose down
docker compose up -d

# Final message
echo "✅ Done."