#!/bin/bash
set -e

# Variables (customize accordingly)
AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="YOUR_ACCOUNT_ID"
BACKEND_IMAGE="backend-fargate"
FRONTEND_IMAGE="frontend-fargate"
ECS_CLUSTER="fargate-cluster"
BACKEND_SERVICE="backend-service"
FRONTEND_SERVICE="frontend-service"
REPO_NAME_BACKEND="backend"
REPO_NAME_FRONTEND="frontend"

# 1. Authenticate Docker with ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# 2. Create ECR repos if not exists
aws ecr describe-repositories --repository-names $REPO_NAME_BACKEND || aws ecr create-repository --repository-name $REPO_NAME_BACKEND
aws ecr describe-repositories --repository-names $REPO_NAME_FRONTEND || aws ecr create-repository --repository-name $REPO_NAME_FRONTEND

# 3. Build and push images
docker build -t $REPO_NAME_BACKEND ./backend
docker tag $REPO_NAME_BACKEND:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME_BACKEND:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME_BACKEND:latest

docker build -t $REPO_NAME_FRONTEND ./frontend
docker tag $REPO_NAME_FRONTEND:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME_FRONTEND:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME_FRONTEND:latest

echo "Docker images pushed to ECR. Define ECS task definitions and services manually or via IaC."

