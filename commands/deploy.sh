#!/bin/bash

set -e

REPO_URL="https://github.com/Sotnikov-100/py-fastapi-homework-5-ec2-deploy-task.git"
APP_DIR="/home/ubuntu/py-fastapi-homework-5-ec2-deploy-task"

handle_error() {
    echo "❌ Error: $1"
    exit 1
}

# Клонувати, якщо папка не існує
if [ ! -d "$APP_DIR" ]; then
    echo "🔄 Cloning the repository..."
    git clone "$REPO_URL" "$APP_DIR" || handle_error "Failed to clone repository"
fi

cd "$APP_DIR" || handle_error "Failed to enter app directory"

echo "🔃 Fetching latest changes..."
git fetch origin main || handle_error "Failed to fetch"
git reset --hard origin/main || handle_error "Failed to reset"

echo "🐳 Running Docker Compose..."
docker compose -f docker-compose-prod.yml up -d --build || handle_error "Docker Compose failed"

echo "✅ Deployment completed successfully."
