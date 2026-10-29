# DevOps Capstone Project – Accounts Service

![Build Status](https://github.com/The-Creative-Developer/devops-capstone-project/actions/workflows/ci-build.yaml/badge.svg)
![Python](https://img.shields.io/badge/python-3.9-blue)

A RESTful **Customer Accounts microservice** built with Flask for the IBM DevOps Capstone Project
(Coursera). It is developed test-first, secured with Flask-Talisman and Flask-Cors, built by
GitHub Actions, containerized with Docker, deployed to Kubernetes/OpenShift and delivered through a
Tekton CD pipeline.

## Endpoints

| Method | URL | Description | Success |
|--------|-----|-------------|---------|
| GET | `/` | Service name and version | 200 |
| GET | `/health` | Health probe | 200 |
| POST | `/accounts` | Create an account | 201 + `Location` |
| GET | `/accounts` | List all accounts | 200 |
| GET | `/accounts/<id>` | Read an account | 200 / 404 |
| PUT | `/accounts/<id>` | Update an account | 200 / 404 |
| DELETE | `/accounts/<id>` | Delete an account | 204 |

Account fields: `id`, `name`, `email`, `address`, `phone_number` (optional), `date_joined`.

## Project layout

```
service/            Flask app (models.py = M, routes.py = C, JSON = V)
  common/           status codes, error handlers, logging, CLI commands
tests/              nose unit tests (models, routes, CLI) + factories
.github/workflows/  ci-build.yaml  (GitHub Actions CI)
.github/ISSUE_TEMPLATE/user-story.md
deploy/             Kubernetes manifests (deployment, service, postgres)
tekton/             Tekton tasks, pipeline, PVC, triggers
docs/               user stories, manual-steps checklist, captured evidence
Dockerfile          container image (accounts)
setup.cfg           nosetests, coverage, flake8, pylint configuration
```

## Quick start

```bash
make venv && source .venv/bin/activate   # needs Python 3.9 (nose does not run on 3.10+)
make install
make db                                  # PostgreSQL in Docker (or set DATABASE_URI)
make tests                               # nosetests, coverage >= 95%
make run                                 # http://localhost:8080
```

Use SQLite instead of Postgres for a quick run: `export DATABASE_URI=sqlite:////tmp/accounts.db`.

Because Flask-Talisman forces HTTPS, plain-HTTP calls get a redirect. Send the header a TLS-terminating
proxy would add: `curl -H "X-Forwarded-Proto: https" http://localhost:8080/accounts`.

## Docker / Kubernetes

```bash
make build                       # docker build -t accounts:1 .
make deploy                      # Postgres + accounts deployment + service
kubectl get all -l app=accounts
```

## CD pipeline (Tekton)

`make tekton` installs Tekton on a local cluster; `make pipeline` applies the tasks, pipeline and trigger.
Pipeline: `init → clone → (lint ∥ tests) → build → deploy`.

## Evidence & submission

See [docs/MANUAL_STEPS.md](docs/MANUAL_STEPS.md) for the submission checklist, what is already captured
in `docs/evidence/`, and what you still need to do.

## License

Apache-2.0. Project structure inspired by the IBM Skills Network capstone template.
