# Final Submission – Option 1: AI Graded

Repo: https://github.com/The-Creative-Developer/devops-capstone-project
CI run (passing): https://github.com/The-Creative-Developer/devops-capstone-project/actions/runs/40911257186

## GitHub URLs

| Checklist item | URL |
|---|---|
| README.md (project name + build badge) | https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/README.md |
| user-story.md template | https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/.github/ISSUE_TEMPLATE/user-story.md |
| setup.cfg | https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/setup.cfg |
| ci-build.yaml | https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/.github/workflows/ci-build.yaml |
| `__init__.py` (Talisman + CORS) | https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/service/__init__.py |
| Dockerfile | https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/Dockerfile |

## Output files (`docs/evidence/`)

| Checklist item | File | Status |
|---|---|---|
| CREATE cURL | `rest-create-done` | ready |
| LIST cURL | `rest-list-done` | ready |
| READ cURL | `rest-read-done` | ready |
| UPDATE cURL | `rest-update-done` | ready |
| DELETE cURL | `rest-delete-done` | ready |
| CI workflow steps | `ci-workflow-done` | ready (real GitHub Actions log, all steps green) |
| nosetests after CORS/Talisman | `security-headers-done` | ready (33 tests, 98%) |
| App JSON on port 8080 | `kube-app-output` | ready (served from the Kubernetes cluster) |
| Docker images | `kube-images` | ready |
| Kubernetes deployment details | `kube-deploy-accounts` | ready (kind cluster: deployment, pod, replica sets, service) |
| Tekton pipeline logs | `pipelinerun.txt` | ready (all 6 tasks Succeeded) |

## ZenHub board screenshots (`docs/screenshots/`)

GitHub issues 1–11 exist: https://github.com/The-Creative-Developer/devops-capstone-project/issues

| Checklist item | File | Status |
|---|---|---|
| All stories in New Issues | `Planning-userstories-done.jpeg` | captured |
| Stories in Ice Box | `planning-productbacklog-done.jpeg` | captured |
| Technical Debt / Enhancement labels | `planning-labels-done.jpeg` | captured |
| Sprint 1 in Sprint Backlog | `planning-kanban-done.jpeg` | captured |
| Dev environment story Done | `rest-techdebt-done.jpeg` | captured |
| Read account Done | `read-accounts.jpeg` | captured |
| List accounts Done | `list-accounts.jpeg` | captured |
| Update account Done | `update-accounts.jpeg` | captured |
| Delete account Done | `delete-accounts.jpeg` | captured |
| Sprint 2 plan (2 stories) | `sprint2-plan.jpeg` | captured |
| CI story Done | `ci-kanban-done.jpeg` | captured |
| Security story Done | `security-kanban-done.jpeg` | captured |
| Sprint 3 plan (3 stories) | `sprint3-plan.jpeg` | captured |
| Docker story Done | `kube-docker-done.jpeg` | captured |
| Kubernetes story Done | `kube-kubernetes-done.jpeg` | captured |
| CD pipeline story Done | `cd-pipeline-done.jpeg` | captured |
