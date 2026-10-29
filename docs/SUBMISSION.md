# Final Submission – 33 Tasks, in Submission Order

Repo: https://github.com/The-Creative-Developer/devops-capstone-project
Base URL for file links: `https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/`

* **URL** = paste the link. **File** = upload the file from this repo (exact name shown, no extension for the text outputs).
* Screenshots are in `docs/screenshots/`, text outputs in `docs/evidence/`.

| # | Pts | Deliverable | Type | What to submit |
|---|----|-------------|------|----------------|
| 1 | 2 | README.md with project name + passing build badge | URL | https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/README.md |
| 2 | 1 | user-story.md template | URL | https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/.github/ISSUE_TEMPLATE/user-story.md |
| 3 | 1 | All stories in New Issues | File | `docs/screenshots/planning-userstories-done.jpeg` |
| 4 | 1 | Stories under Ice Box | File | `docs/screenshots/planning-productbacklog-done.jpeg` |
| 5 | 1 | Product Backlog stories labelled Technical Debt / Enhancement | File | `docs/screenshots/planning-labels-done.png` |
| 6 | 1 | Sprint Backlog stories with estimates, assigned to first sprint | File | `docs/screenshots/planning-kanban-done.png` |
| 7 | 1 | setup.cfg | URL | https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/setup.cfg |
| 8 | 1 | "Setting up the development environment" in Done | File | `docs/screenshots/rest-techdebt-done.png` |
| 9 | 1 | "Read an account from the service" in Done | File | `docs/screenshots/read-accounts.png` |
| 10 | 1 | "List all accounts in the service" in Done | File | `docs/screenshots/list-accounts.png` |
| 11 | 1 | "Update an account in the service" in Done | File | `docs/screenshots/update-accounts.png` |
| 12 | 1 | "Delete an account from the service" in Done | File | `docs/screenshots/delete-accounts.png` |
| 13 | 2 | cURL CREATE command + output | File | `docs/evidence/rest-create-done` |
| 14 | 2 | cURL LIST command + output | File | `docs/evidence/rest-list-done` |
| 15 | 2 | cURL READ command + output | File | `docs/evidence/rest-read-done` |
| 16 | 2 | cURL UPDATE command + output | File | `docs/evidence/rest-update-done` |
| 17 | 2 | cURL DELETE command + output | File | `docs/evidence/rest-delete-done` |
| 18 | 1 | Two new Sprint 2 stories in Sprint Backlog | File | `docs/screenshots/sprint2-plan.png` |
| 19 | 2 | GitHub Actions run output, all steps | File | `docs/evidence/ci-workflow-done` |
| 20 | 1 | "Need the ability to automate continuous integration checks" in Done | File | `docs/screenshots/ci-kanban-done.png` |
| 21 | 4 | ci-build.yaml (checkout → lint → nosetests) | URL | https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/.github/workflows/ci-build.yaml |
| 22 | 1 | `__init__.py` with Talisman | URL | https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/service/__init__.py |
| 23 | 1 | nosetests output, all passing, with CORS | File | `docs/evidence/security-headers-done` |
| 24 | 1 | "Need to add security headers and CORS policies" in Done | File | `docs/screenshots/security-kanban-done.png` |
| 25 | 1 | Three Sprint 3 stories | File | `docs/screenshots/sprint3-plan.png` |
| 26 | 1 | JSON output of the app on port 8080 | File | `docs/evidence/kube-app-output` |
| 27 | 1 | "Containerize your microservice using Docker" in Done | File | `docs/screenshots/kube-docker-done.png` |
| 28 | 1 | "Deploy your Docker image to Kubernetes" in Done | File | `docs/screenshots/kube-kubernetes-done.png` |
| 29 | 2 | Dockerfile | URL | https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/Dockerfile |
| 30 | 2 | Docker image details (name, tag, id, created, size) | File | `docs/evidence/kube-images` |
| 31 | 2 | Deployment, pods, replica sets, service | File | `docs/evidence/kube-deploy-accounts` |
| 32 | 5 | Complete Tekton pipeline logs | File | `docs/evidence/pipelinerun.txt` |
| 33 | 1 | "Create a CD pipeline to automate deployment to Kubernetes" in Done | File | `docs/screenshots/cd-pipeline-done.png` |

Total: 50 points (pass = 35).

## Notes

* **Evidence provenance:** `rest-*-done` and `security-headers-done` were generated against SQLite; `kube-*` and `pipelinerun.txt` came from a kind cluster with Postgres; `ci-workflow-done` is the real GitHub Actions log (step name shown in each line).
* **Board:** ZenHub workspace "The Singularity" (repo connected). Stories have 3-point estimates; sprints: S1 Oct 26–Nov 9, S2 Nov 9–23, S3 Nov 23–Dec 7. ZenHub adds the current sprint when a card moves to Done, so Done cards may show "and 1 more".
* If the upload form insists on an extension for the text files, upload a copy renamed `<name>.txt`.
