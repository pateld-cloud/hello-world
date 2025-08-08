# FastAPI + React App Deployed to AWS Fargate

## 🧩 Overview

This repo contains a containerized FastAPI backend and a React frontend, deployed via AWS Fargate. The deployment uses a Bash script and CI/CD via GitHub Actions.

---

## 🚀 Local Docker Run

###### Backend (FastAPI)

```bash
cd backend
docker build -t backend-app .
docker run -p 8080:80 backend-app

### Frontend (React)
cd frontend
docker build -t frontend-app .
docker run -p 3000:80 frontend-app

### Deployment Script
1. Builds Docker images for backend (FastAPI) and frontend (React).
2. Tags and pushes the images to AWS ECR.
3. (Optionally) Updates ECS Fargate services with new images.

### Prerequisites
AWS CLI installed and configured (aws configure)
AWS account with:
    ECR repos: fastapi-app, react-app
    ECS Cluster and services already created (or use Terraform)
IAM roles to allow ECR and ECS access

### CI/CD with GitHub Actions
Secrets required:
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEYi

### Monitoring & Logging (Conceptual)
Logs:
    Use AWS CloudWatch logs from ECS task definitions.
Monitoring:
    Use AWS CloudWatch alarms and metrics on CPU/memory.
    Set up alerts on container health and availability.
Optional tools:
    Datadog, Prometheus + Grafana (self-hosted)
