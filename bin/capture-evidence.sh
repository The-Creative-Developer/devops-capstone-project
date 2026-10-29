#!/usr/bin/env bash
# Starts the Accounts service locally and records the cURL command + output for
# each REST operation into docs/evidence/rest-*-done files.
#
# Usage: bin/capture-evidence.sh            (uses SQLite unless DATABASE_URI is set)
set -euo pipefail

cd "$(dirname "$0")/.."
OUT=docs/evidence
PORT=${PORT:-8080}
BASE="http://localhost:${PORT}"
mkdir -p "$OUT"

export DATABASE_URI="${DATABASE_URI:-sqlite:////tmp/accounts-evidence.db}"
rm -f /tmp/accounts-evidence.db
PY=.venv/bin
[ -x "$PY/gunicorn" ] || PY=$(dirname "$(command -v gunicorn)")

"$PY/gunicorn" --bind "0.0.0.0:${PORT}" --log-level=warning service:app &
PID=$!
trap 'kill $PID 2>/dev/null || true' EXIT
for _ in $(seq 1 30); do
  curl -s -o /dev/null "${BASE}/health" -H "X-Forwarded-Proto: https" && break
  sleep 1
done

# X-Forwarded-Proto simulates the TLS-terminating ingress/route in front of the
# service so Flask-Talisman does not redirect plain HTTP to HTTPS.
H=(-H "X-Forwarded-Proto: https")
J=(-H "Content-Type: application/json")

record() {  # record <file> <title> <cmd...>
  local file=$1 title=$2; shift 2
  {
    echo "# ${title}"
    echo "\$ $*"
    "$@"
    echo
  } 2>&1 | tee -a "$OUT/$file" >/dev/null
}

for f in create list read update delete; do : > "$OUT/rest-$f-done"; done

CREATE1='{"name":"Alice Johnson","email":"alice@example.com","address":"12 Elm Street, Springfield","phone_number":"555-0101","date_joined":"2022-03-15"}'
CREATE2='{"name":"Bob Smith","email":"bob@example.com","address":"34 Oak Avenue, Shelbyville","phone_number":"555-0102","date_joined":"2023-07-01"}'

# CREATE
record rest-create-done "CREATE an account (POST /accounts)" \
  curl -i -s -X POST "${BASE}/accounts" "${H[@]}" "${J[@]}" -d "$CREATE1"
record rest-create-done "CREATE a second account (POST /accounts)" \
  curl -i -s -X POST "${BASE}/accounts" "${H[@]}" "${J[@]}" -d "$CREATE2"

# LIST
record rest-list-done "LIST all accounts (GET /accounts)" \
  curl -i -s -X GET "${BASE}/accounts" "${H[@]}"

# READ
record rest-read-done "READ account 1 (GET /accounts/1)" \
  curl -i -s -X GET "${BASE}/accounts/1" "${H[@]}"
record rest-read-done "READ a missing account (GET /accounts/999) -> 404" \
  curl -i -s -X GET "${BASE}/accounts/999" "${H[@]}"

# UPDATE
record rest-update-done "UPDATE account 1 (PUT /accounts/1)" \
  curl -i -s -X PUT "${BASE}/accounts/1" "${H[@]}" "${J[@]}" \
  -d '{"name":"Alice Johnson-Lee","email":"alice.lee@example.com","address":"99 Pine Road, Springfield","phone_number":"555-0199","date_joined":"2022-03-15"}'
record rest-update-done "READ account 1 again to confirm the update" \
  curl -i -s -X GET "${BASE}/accounts/1" "${H[@]}"

# DELETE
record rest-delete-done "DELETE account 2 (DELETE /accounts/2)" \
  curl -i -s -X DELETE "${BASE}/accounts/2" "${H[@]}"
record rest-delete-done "LIST to confirm account 2 is gone" \
  curl -i -s -X GET "${BASE}/accounts" "${H[@]}"
record rest-delete-done "READ the deleted account (GET /accounts/2) -> 404" \
  curl -i -s -X GET "${BASE}/accounts/2" "${H[@]}"

# Application launch output (kube-app-output)
{
  echo "\$ curl -s ${BASE}/"
  curl -s "${BASE}/" "${H[@]}"
} > "$OUT/kube-app-output"

echo "Evidence written to $OUT"
