# Legal App — CI/CD Pipeline Project

**Subject:** DevOps  
**Tools:** Git, Docker, GitHub Actions, Kubernetes (K8s)  
**Problem Statement:** CI/CD for Ruby on Rails Legal App

---

## Team Members

| # | Name | Enrollment No |
|---|------|---------------|
| 1 | Animesh Parashar | EN22CS301128 |
| 2 | Anirudh Singh Rathore | EN22CS301130 |
| 3 | Anshika Parsai | EN22CS301151 |
| 4 | Anshul Goyal | EN22CS301157 |

---

## Project Description

A CI/CD pipeline for a Ruby on Rails Legal App using GitHub Actions. The pipeline automates:
- ✅ Unit testing via RSpec on every commit/PR
- ✅ Containerized Docker image build on merge to `main`
- ✅ Automatic push to GitHub Container Registry (GHCR)
- ✅ Kubernetes deployment with rolling updates

---

## Quick Start (From Scratch)

### Step 1 — Install Prerequisites

**Windows:**
```bash
# Install Git
winget install Git.Git

# Install Docker Desktop
# Download from: https://www.docker.com/products/docker-desktop/

# Install Ruby (via RubyInstaller)
# Download from: https://rubyinstaller.org/downloads/
# Choose Ruby+Devkit 3.2.x (x64)
```

**macOS:**
```bash
brew install git ruby
brew install --cask docker
```

**Ubuntu/Linux:**
```bash
sudo apt update
sudo apt install git docker.io docker-compose curl
# Install rbenv for Ruby
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-installer | bash
rbenv install 3.2.0 && rbenv global 3.2.0
```

---

### Step 2 — Clone and Run Locally

```bash
git clone https://github.com/YOUR_USERNAME/legal_app.git
cd legal_app

# Run with Docker Compose (easiest)
docker compose up --build

# App runs at: http://localhost:3000
```

---

### Step 3 — Run Tests Locally

```bash
# Without Docker
bundle install
bundle exec rails db:create db:migrate RAILS_ENV=test
bundle exec rspec

# With Docker
docker compose run web bundle exec rspec
```

---

### Step 4 — Push to GitHub (triggers CI/CD)

```bash
git add .
git commit -m "feat: add CI/CD pipeline"
git push origin main
```

Go to GitHub → Actions tab → watch the pipeline run automatically.

---

### Step 5 — Set Up Kubernetes (Optional for review demo)

```bash
# Create secrets first
kubectl create secret generic legal-app-secrets \
  --from-literal=database-url="postgres://user:pass@host/legal_app_production" \
  --from-literal=secret-key-base="$(bundle exec rails secret)"

# Deploy
kubectl apply -f k8s/
kubectl get pods
kubectl get services
```

---

## Pipeline Flow

```
Developer pushes code
        ↓
GitHub Actions triggered
        ↓
JOB 1: RSpec tests run (PostgreSQL spun up automatically)
        ↓ (only if tests pass)
JOB 2: Docker image built & pushed to GHCR
        ↓ (only on main branch)
JOB 3: Kubernetes pulls new image & deploys
        ↓
kubectl rollout status confirms healthy deployment
```

---

## Project Structure

```
legal_app/
├── app/
│   ├── controllers/cases_controller.rb   # REST API for legal cases
│   └── models/case.rb                    # Case model with validations
├── spec/
│   ├── models/case_spec.rb               # Unit tests
│   └── requests/cases_spec.rb            # Integration tests
├── k8s/
│   ├── deployment.yaml                   # K8s deployment (2 replicas)
│   └── service.yaml                      # LoadBalancer service
├── .github/workflows/ci.yml              # Full CI/CD pipeline
├── Dockerfile                            # Container definition
├── docker-compose.yml                    # Local dev environment
└── README.md                             # This file
```

---

## API Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| GET | /cases | List all cases |
| GET | /cases/:id | Get one case |
| POST | /cases | Create a case |
| PUT | /cases/:id | Update a case |
| DELETE | /cases/:id | Delete a case |

---

## Key Concepts Demonstrated

| Concept | Implementation |
|---------|---------------|
| Continuous Integration | RSpec runs on every push automatically |
| Continuous Delivery | Docker image built only after tests pass |
| Containerization | Dockerfile + docker-compose for reproducible env |
| Container Registry | GitHub Container Registry (GHCR) |
| Orchestration | Kubernetes with 2 replicas + health checks |
| Secrets Management | K8s Secrets for DB credentials |
| Rolling Updates | `kubectl rollout` ensures zero downtime |
