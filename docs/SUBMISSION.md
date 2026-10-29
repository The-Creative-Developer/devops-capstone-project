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
| App JSON on port 8080 | `kube-app-output` | ready (local run) |
| Docker images | `kube-images` | **needs Docker Desktop running** |
| Kubernetes deployment details | `kube-deploy-accounts` | **needs a cluster** |
| Tekton pipeline logs | `pipelinerun.txt` | **needs a cluster** |

## ZenHub board screenshots (`docs/screenshots/`)

GitHub issues 1–11 exist: https://github.com/The-Creative-Developer/devops-capstone-project/issues

| Checklist item | File | Status |
|---|---|---|
| All stories in New Issues | `Planning-userstories-done` | pending |
| Stories in Ice Box | `planning-productbacklog-done` | pending |
| Technical Debt / Enhancement labels | `planning-labels-done` | pending |
| Sprint 1 in Sprint Backlog | `planning-kanban-done` | pending |
| Dev environment story Done | `rest-techdebt-done` | pending |
| Read account Done | `read-accounts` | pending |
| List accounts Done | `list-accounts` | pending |
| Update account Done | `update-accounts` | pending |
| Delete account Done | `delete-accounts` | pending |
| Sprint 2 plan (2 stories) | `sprint2-plan` | pending |
| CI story Done | `ci-kanban-done` | pending |
| Security story Done | `security-kanban-done` | pending |
| Sprint 3 plan (3 stories) | `sprint3-plan` | pending |
| Docker story Done | `kube-docker-done` | pending |
| Kubernetes story Done | `kube-kubernetes-done` | pending |
| CD pipeline story Done | `cd-pipeline-done` | pending |
