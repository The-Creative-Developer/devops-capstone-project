# These can be overidden with env vars.
REGISTRY ?= localhost:32000
IMAGE_NAME ?= accounts
IMAGE_TAG ?= 1
IMAGE ?= $(IMAGE_NAME):$(IMAGE_TAG)

.PHONY: help
help: ## Display this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: venv
venv: ## Create a Python virtual environment
	python3.9 -m venv .venv

.PHONY: install
install: ## Install Python dependencies
	python -m pip install --upgrade pip wheel
	pip install -r requirements.txt

.PHONY: lint
lint: ## Run the linter
	flake8 service --count --select=E9,F63,F7,F82 --show-source --statistics
	flake8 service --count --max-complexity=10 --max-line-length=127 --statistics
	pylint service --max-line-length=127

.PHONY: tests
tests: ## Run the unit tests
	nosetests

.PHONY: run
run: ## Run the service
	honcho start

.PHONY: db
db: ## Run PostgreSQL in Docker for local development/testing
	docker run -d --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=postgres -v postgres:/var/lib/postgresql/data postgres:alpine

.PHONY: dbrm
dbrm: ## Remove the PostgreSQL container
	docker stop postgres && docker rm postgres

.PHONY: build
build: ## Build the docker image
	docker build -t $(IMAGE) .

.PHONY: push
push: ## Tag and push the image to the registry
	docker tag $(IMAGE) $(REGISTRY)/$(IMAGE)
	docker push $(REGISTRY)/$(IMAGE)

.PHONY: cluster
cluster: ## Create a local k3d Kubernetes cluster with a registry
	k3d cluster create --agents 1 --registry-create cluster-registry:0.0.0.0:32000 --port '8080:80@loadbalancer'

.PHONY: tekton
tekton: ## Install Tekton pipelines, triggers and dashboard
	kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
	kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
	kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml
	kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml

.PHONY: clustertasks
clustertasks: ## Install git-clone, buildah and openshift-client Tasks from the Tekton catalog
	kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.9/git-clone.yaml
	kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/buildah/0.9/buildah.yaml
	kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/openshift-client/0.2/openshift-client.yaml

.PHONY: deploy
deploy: ## Deploy Postgres and the Accounts service
	kubectl apply -f deploy/postgres.yaml
	kubectl apply -f deploy/deployment.yaml
	kubectl apply -f deploy/service.yaml

.PHONY: pipeline
pipeline: ## Apply the Tekton tasks, pipeline, PVC and trigger
	kubectl apply -f tekton/pvc.yaml
	kubectl apply -f tekton/tasks.yaml
	kubectl apply -f tekton/pipeline.yaml
	kubectl apply -f tekton/events.yaml
