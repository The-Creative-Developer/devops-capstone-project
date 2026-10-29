# Option 2 – Peer-Graded Submission (34 items, in order)

Repo: https://github.com/The-Creative-Developer/devops-capstone-project
All uploads are in [`docs/peer-review/`](peer-review/) with the exact names below.
Base URL: `https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/`

| # | Task | Pts | Submit |
|---|------|----|--------|
| 1 | 1a Repository created | 1 | `planning-repository-done.jpg` |
| 2 | 1b User-story template in repo | 1 | `planning-storytemplate-done.jpg` |
| 3 | 1c All stories in New Issues | 1 | `planning-userstories-done.jpg` |
| 4 | 1d Stories under Ice Box | 1 | `planning-productbacklog-done.jpg` |
| 5 | 1e Labels: Technical Debt / Enhancement | 1 | `planning-labels-done.jpg` |
| 6 | 1f Stories in Sprint Backlog | 1 | `planning-kanban-done.jpg` |
| 7 | 2a setup.cfg | 1 | `rest-setupcfg-done.jpg` |
| 8 | 2b "Setting up the development environment" Done | 1 | `rest-techdebt-done.jpg` |
| 9 | 2c Read account Done | 1 | `read-accounts.jpg` |
| 10 | 2d List accounts Done | 1 | `list-accounts.jpg` |
| 11 | 2e Update account Done | 1 | `update-accounts.jpg` |
| 12 | 2f Delete account Done | 1 | `delete-accounts.jpg` |
| 13 | 2g cURL CREATE | 2 | `rest-create-done.jpg` |
| 14 | 2h cURL READ | 2 | `rest-read-done.jpg` |
| 15 | 2i cURL LIST | 2 | `rest-list-done.jpg` |
| 16 | 2j cURL UPDATE | 2 | `rest-update-done.jpg` |
| 17 | 2k cURL DELETE | 2 | `rest-delete-done.jpg` |
| 18 | 3a Two Sprint 2 stories | 1 | `sprint2-plan.jpg` |
| 19 | 3b Successful GitHub Actions run | 2 | `ci-workflow-done.jpg` |
| 20 | 3c CI badge in README | 1 | `ci-badge-done.jpg` |
| 21 | 3d CI story Done | 1 | `ci-kanban-done.jpg` |
| 22 | 3e ci-build.yaml URL | 4 | https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/.github/workflows/ci-build.yaml |
| 23 | 3i Security header + CORS code | 1 | `security-code-done.jpg` |
| 24 | 3j Talisman + CORS headers in running app | 1 | `security-headers-done.jpg` |
| 25 | 3k Security story Done | 1 | `security-kanban-done.jpg` |
| 26 | 4a Three Sprint 3 stories | 1 | `sprint3-plan.jpg` |
| 27 | 4b JSON from app on port 8080 | 1 | `kube-app-output.jpg` |
| 28 | 4c Docker story Done | 1 | `kube-docker-done.jpg` |
| 29 | 4d Dockerfile URL | 2 | https://github.com/The-Creative-Developer/devops-capstone-project/blob/main/Dockerfile |
| 30 | 4e Docker image details | 2 | `kube-images.jpg` |
| 31 | 4f Deployment, pods, replicasets, services | 2 | `kube-deploy-accounts.jpg` |
| 32 | 4g Kubernetes story Done | 1 | `kube-kubernetes-done.jpg` |
| 33 | 5a Tekton pipeline logs | 5 | `pipelinerun.txt` |
| 34 | 5b CD pipeline story Done | 1 | `cd-pipeline-done.jpg` |

## Notes

* Items 1–2, 7, 13–17, 19–20, 23–24, 27, 30–31 are screenshots of the public GitHub pages for the committed files (rendered with headless Chrome); the underlying text is in `docs/evidence/`.
* Items 3–6, 8–12, 18, 21, 25–26, 28, 32, 34 are the ZenHub board captures (ZenHub workspace "The Singularity").
* Item 24 uses `docs/evidence/security-headers-curl`: a live `curl -i` against the running service showing `Strict-Transport-Security`, `X-Frame-Options`, `Content-Security-Policy`, `Referrer-Policy` (Talisman) and `Access-Control-Allow-Origin` (Flask-Cors).
* Option 1 (AI graded) files remain in `docs/SUBMISSION.md`; submit under **one** option only.
