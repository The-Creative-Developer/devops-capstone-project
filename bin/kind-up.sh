#!/usr/bin/env bash
# Creates a local kind cluster plus a local container registry reachable from
# pods and nodes as kind-registry:5000 (also published on localhost:5001).
set -euo pipefail
REG=kind-registry
if [ "$(docker inspect -f '{{.State.Running}}' "$REG" 2>/dev/null || true)" != "true" ]; then
  docker run -d --restart=always -p 127.0.0.1:5001:5000 --network bridge --name "$REG" registry:2
fi
cat <<CFG | kind create cluster --name capstone --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
containerdConfigPatches:
- |-
  [plugins."io.containerd.grpc.v1.cri".registry]
    config_path = "/etc/containerd/certs.d"
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 30080
    hostPort: 30080
CFG
if [ "$(docker inspect -f='{{json .NetworkSettings.Networks.kind}}' "$REG")" = 'null' ]; then
  docker network connect kind "$REG"
fi
for node in $(kind get nodes --name capstone); do
  docker exec "$node" mkdir -p /etc/containerd/certs.d/${REG}:5000
  cat <<TOML | docker exec -i "$node" tee /etc/containerd/certs.d/${REG}:5000/hosts.toml >/dev/null
server = "http://${REG}:5000"
[host."http://${REG}:5000"]
  capabilities = ["pull", "resolve", "push"]
TOML
done
