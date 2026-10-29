# Product Backlog – User Stories

Each story follows the template in `.github/ISSUE_TEMPLATE/user-story.md`.
`bin/create-issues.sh` creates these as GitHub issues (with labels) so ZenHub can pick them up.

## Sprint 1 – Develop a RESTful service using TDD

### 1. Setting up the development environment  `technical debt`
**As a** developer
**I need** a development environment with the tools and dependencies configured
**So that** I can develop and test the Accounts service consistently

Details and assumptions:
* Python 3.9 virtual environment, requirements.txt, setup.cfg for nose/coverage/flake8/pylint
* PostgreSQL available for local testing

Acceptance criteria:
```gherkin
Given a fresh clone of the repository
When I run make install and make tests
Then all dependencies install and the test suite runs with coverage reported
```

### 2. Create an account in the service  `enhancement`
**As a** service consumer
**I need** to create an account via REST
**So that** new customers can be stored in the system

```gherkin
Given valid account JSON
When I POST it to /accounts
Then I receive 201 CREATED with a Location header and the stored account
```

### 3. Read an account from the service  `enhancement`
**As a** service consumer
**I need** to read an account by id
**So that** I can view a customer's details

```gherkin
Given an account exists with id 1
When I GET /accounts/1
Then I receive 200 OK and the account JSON
And GET /accounts/999 returns 404 NOT FOUND
```

### 4. Update an account in the service  `enhancement`
**As a** service consumer
**I need** to update an existing account
**So that** customer details stay current

```gherkin
Given an account exists with id 1
When I PUT changed JSON to /accounts/1
Then I receive 200 OK and the updated account
```

### 5. Delete an account from the service  `enhancement`
**As a** service consumer
**I need** to delete an account
**So that** I can remove customers who leave

```gherkin
Given an account exists with id 1
When I DELETE /accounts/1
Then I receive 204 NO CONTENT and the account no longer exists
```

### 6. List all accounts in the service  `enhancement`
**As a** service consumer
**I need** to list all accounts
**So that** I can see every customer

```gherkin
Given several accounts exist
When I GET /accounts
Then I receive 200 OK and a JSON list of all accounts
```

## Sprint 2 – Add CI and security

### 7. Automate the build with continuous integration  `technical debt`
**As a** developer
**I need** a GitHub Actions workflow that lints and tests on every push and pull request
**So that** broken code is caught immediately

```gherkin
Given a push or pull request to main
When the CI Build workflow runs
Then flake8 and nosetests execute against a PostgreSQL service container and pass
```

### 8. Add security headers and CORS policies  `enhancement`
**As a** security engineer
**I need** Flask-Talisman security headers and Flask-Cors CORS policy
**So that** the service resists common web attacks

```gherkin
Given the service is running
When I request any endpoint over HTTPS
Then the response includes X-Frame-Options, X-Content-Type-Options, Content-Security-Policy,
     Referrer-Policy and Access-Control-Allow-Origin headers
```

## Sprint 3 – Deploy to Kubernetes

### 9. Containerize the service with Docker  `technical debt`
**As a** DevOps engineer
**I need** a Dockerfile that builds an `accounts` image
**So that** the service runs the same everywhere

```gherkin
Given the repository
When I run docker build -t accounts:1 .
Then an image named accounts is created that serves on port 8080
```

### 10. Deploy the service to Kubernetes  `technical debt`
**As a** DevOps engineer
**I need** Kubernetes manifests for the service and database
**So that** the service runs with scaling and self-healing

```gherkin
Given a Kubernetes/OpenShift cluster
When I apply deploy/*.yaml
Then the accounts deployment, pod, replica set and service are running
```

### 11. Automate deployment with a CD pipeline  `technical debt`
**As a** DevOps engineer
**I need** a Tekton pipeline (clone, lint, test, build, deploy) with a trigger
**So that** every commit is deployed automatically

```gherkin
Given the Tekton pipeline is installed
When I start a PipelineRun (or push a commit that fires the trigger)
Then all five tasks succeed and the new image is deployed
```
