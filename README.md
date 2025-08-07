# FastAPI + React App Deployed to AWS Fargate

## 🧩 Overview

This repo contains a containerized FastAPI backend and a React frontend, deployed via AWS Fargate. The deployment uses a Bash script and CI/CD via GitHub Actions.

---

## 🚀 Local Docker Run

### Backend (FastAPI)

```bash
cd backend
docker build -t backend-app .
docker run -p 8080:80 backend-app

### Frontend (React)

cd frontend
docker build -t frontend-app .
docker run -p 3000:80 frontend-app

