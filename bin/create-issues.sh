#!/usr/bin/env bash
# Creates the capstone labels and user-story issues in the current GitHub repo.
# Requires: gh auth login, and run from inside the cloned repo.
set -euo pipefail

gh label create "technical debt" --color "d93f0b" --description "Technical debt" --force
gh label create "enhancement" --color "a2eeef" --description "New feature or request" --force

story() {  # story <title> <label> <as-a> <need> <so-that> <given> <when> <then>
  local body
  body=$(printf '**As a** %s\n**I need** %s\n**So that** %s\n\n### Details and Assumptions\n* See docs/user-stories.md\n\n### Acceptance Criteria\n```gherkin\nGiven %s\nWhen %s\nThen %s\n```\n' "$3" "$4" "$5" "$6" "$7" "$8")
  gh issue create --title "$1" --label "$2" --body "$body"
}

story "Setting up the development environment" "technical debt" "developer" \
  "a development environment with the tools and dependencies configured" \
  "I can develop and test the Accounts service consistently" \
  "a fresh clone of the repository" "I run make install and make tests" \
  "all dependencies install and the test suite runs with coverage reported"
story "Create an account in the service" "enhancement" "service consumer" \
  "to create an account via REST" "new customers can be stored in the system" \
  "valid account JSON" "I POST it to /accounts" \
  "I receive 201 CREATED with a Location header and the stored account"
story "Read an account from the service" "enhancement" "service consumer" \
  "to read an account by id" "I can view a customer's details" \
  "an account exists with id 1" "I GET /accounts/1" "I receive 200 OK and the account JSON"
story "Update an account in the service" "enhancement" "service consumer" \
  "to update an existing account" "customer details stay current" \
  "an account exists with id 1" "I PUT changed JSON to /accounts/1" "I receive 200 OK and the updated account"
story "Delete an account from the service" "enhancement" "service consumer" \
  "to delete an account" "I can remove customers who leave" \
  "an account exists with id 1" "I DELETE /accounts/1" "I receive 204 NO CONTENT and the account is gone"
story "List all accounts in the service" "enhancement" "service consumer" \
  "to list all accounts" "I can see every customer" \
  "several accounts exist" "I GET /accounts" "I receive 200 OK and a JSON list of all accounts"
story "Need the ability to automate continuous integration checks" "technical debt" "developer" \
  "a GitHub Actions workflow that lints and tests on every push and pull request" \
  "broken code is caught immediately" \
  "a push or pull request to main" "the CI Build workflow runs" \
  "flake8 and nosetests execute against a PostgreSQL service container and pass"
story "Need to add security headers and CORS policies" "enhancement" "security engineer" \
  "Flask-Talisman security headers and Flask-Cors CORS policy" \
  "the service resists common web attacks" \
  "the service is running" "I request any endpoint over HTTPS" \
  "the response includes the security and CORS headers"
story "Containerize your microservice using Docker" "technical debt" "DevOps engineer" \
  "a Dockerfile that builds an accounts image" "the service runs the same everywhere" \
  "the repository" "I run docker build -t accounts:1 ." \
  "an image named accounts is created that serves on port 8080"
story "Deploy your Docker image to Kubernetes" "technical debt" "DevOps engineer" \
  "Kubernetes manifests for the service and database" "the service runs with scaling and self-healing" \
  "a Kubernetes/OpenShift cluster" "I apply deploy/*.yaml" \
  "the accounts deployment, pod, replica set and service are running"
story "Create a CD pipeline to automate deployment to Kubernetes" "technical debt" "DevOps engineer" \
  "a Tekton pipeline (clone, lint, test, build, deploy) with a trigger" \
  "every commit is deployed automatically" \
  "the Tekton pipeline is installed" "I start a PipelineRun or push a commit" \
  "all five tasks succeed and the new image is deployed"
