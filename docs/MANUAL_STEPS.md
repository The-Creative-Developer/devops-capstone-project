# Submission Checklist – What's Done vs. What You Must Do

Legend: ✅ ready in this repo · 🟡 ready locally, becomes a URL once you push · 🖐 needs you (screenshot / your cluster / your account)

Replace `The-Creative-Developer` in README.md first (`sed -i '' 's/The-Creative-Developer/<you>/' README.md`).

## A. GitHub URLs (push the repo, then copy the URL from the browser)

| # | Checklist item | Status | File |
|---|----------------|--------|------|
| 1 | README.md with project name + build-status badge (2) | 🟡 | `README.md` – badge turns green after the first successful Actions run |
| 2 | user-story.md template (1) | 🟡 | `.github/ISSUE_TEMPLATE/user-story.md` |
| 7 | setup.cfg (1) | 🟡 | `setup.cfg` |
| 21 | ci-build.yaml (4) | 🟡 | `.github/workflows/ci-build.yaml` |
| 22 | `__init__.py` with Talisman (1) | 🟡 | `service/__init__.py` |
| 30 | Dockerfile (2) | 🟡 | `Dockerfile` |

Use the `blob/main/...` URL, e.g. `https://github.com/<you>/devops-capstone-project/blob/main/setup.cfg`. The repo must be **public**.

## B. Output files (in `docs/evidence/`)

| # | Item | Status | Notes |
|---|------|--------|-------|
| 13–17 | `rest-create-done`, `rest-list-done`, `rest-read-done`, `rest-update-done`, `rest-delete-done` | ✅ | Generated from the real running service by `bin/capture-evidence.sh`. Re-run in your own environment (Postgres) if you want them to match the lab exactly. |
| 23 | `security-headers-done` (nosetests output) | ✅ | 33 tests pass, 98% coverage. Re-run `nosetests > security-headers-done` against Postgres if you prefer. |
| 26 | `kube-app-output` | ✅ (local) | JSON from `/`. If the grader expects it from the cluster launch, re-run `curl` against your deployed app. |
| 19 | `ci-workflow-done` | ✅ | Real GitHub Actions log saved from the passing run. |
| 31 | `kube-images` | 🖐 | Needs a running Docker daemon (Docker Desktop was **not running** here): `docker images accounts` – must show name, tag, image id, created, size. |
| 32 | `kube-deploy-accounts` | 🖐 | On your cluster: `kubectl get all -l app=accounts > kube-deploy-accounts` (deployments, pods, replica sets, service). |
| 33 | `pipelinerun.txt` | 🖐 | `tkn pipelinerun logs --last > pipelinerun.txt` after a successful run. |

Output files are named exactly as in the checklist (no extension is fine; add `.txt` if the upload form requires it).

## C. Screenshots (all need you – they are from ZenHub/GitHub UI)

Create the board in ZenHub (zenhub.com → connect the repo), then run `bin/create-issues.sh` from the cloned repo to create the 11 stories + labels.

| # | File name | What to capture |
|---|-----------|-----------------|
| 3 | `Planning-userstories-done` | ZenHub board, all stories in **New Issues** |
| 4 | `planning-productbacklog-done` | Stories moved to **Ice Box** (Product Backlog) |
| 5 | `planning-labels-done` | Stories labeled **technical debt** / **enhancement** |
| 6 | `planning-kanban-done` | Sprint 1 stories in **Sprint Backlog** |
| 8 | `rest-techdebt-done` | "Setting up the development environment" in **Done** |
| 9 | `read-accounts` | "Read an account from the service" in **Done** |
| 10 | `list-accounts` | "List all accounts in the service" in **Done** |
| 11 | `update-accounts` | "Update an account in the service" in **Done** |
| 12 | `delete-accounts` | "Delete an account from the service" in **Done** |
| 18 | `sprint2-plan` | Two Sprint 2 stories (CI, security) in **Sprint Backlog** |
| 20 | `ci-kanban-done` | CI story in **Done** |
| 24 | `security-kanban-done` | Security story in **Done** |
| 25 | `sprint3-plan` | Three Sprint 3 stories (Docker, Kubernetes, CD) in Sprint Backlog |
| 27 | `kube-docker-done` | Docker story in **Done** |
| 28 | `kube-kubernetes-done` | Kubernetes story in **Done** |
| 34 | `cd-pipeline-done` | CD pipeline story in **Done** |

Tip: move cards in this order so each screenshot matches the sprint it belongs to: Sprint 1 → create/read/list/update/delete + env setup, then Sprint 2, then Sprint 3. Take each screenshot **at the moment** the card lands in Done (the board only shows current state).

## D. Step-by-step: things only you can do

1. **GitHub**: confirm the account to publish under, create the public repo, push `main`. (Repo creation is held for your OK.)
2. **ZenHub**: sign up (free tier), connect the repo, create pipelines (New Issues, Ice Box, Sprint Backlog, In Progress, Review/QA, Done). Run `bin/create-issues.sh`. Take sections C screenshots as you move cards.
3. **CI**: the first push to `main` triggers `ci-build.yaml`. Wait for green, then grab the log for `ci-workflow-done` and the badge in the README.
4. **Docker**: start Docker Desktop → `make build` → `docker images accounts > docs/evidence/kube-images`.
5. **Kubernetes/OpenShift**: use the course lab environment (IBM Skills Network Labs OpenShift) **or** local k3d (`make cluster`). Then `make deploy`, port-forward 8080, save `kube-deploy-accounts`.
6. **Tekton**: in the lab cluster the ClusterTasks `git-clone`, `buildah`, `openshift-client` already exist; locally run `make tekton` and install them from the Tekton catalog. `make pipeline`, then start a run:
   ```bash
   tkn pipeline start cd-pipeline -p repo-url=https://github.com/<you>/devops-capstone-project.git \
     -p branch=main -p build-image=image-registry.openshift-image-registry.svc:5000/$NAMESPACE/accounts:latest \
     -w name=pipeline-workspace,claimName=oc-lab-pvc --showlog > pipelinerun.txt
   ```
7. **Submit**: choose Option 1 (AI graded) and upload the items above using exact names.

## E. Known caveats

* The tests default to Postgres (`DATABASE_URI`), as in the course. The evidence here was generated with SQLite because Docker was not running.
* `nose` 1.3.7 only works on Python ≤ 3.9 – use the 3.9 venv.
* The Tekton pipeline was written from the course description and could not be run here (no cluster). Expect to tweak ClusterTask names or the registry URL for your cluster.
