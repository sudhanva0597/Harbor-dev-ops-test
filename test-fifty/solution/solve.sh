#!/usr/bin/env bash
set -e

echo "Running Ansible to install Docker..."
ansible-playbook -i localhost, -c local /solution/install-docker.yml

echo "Starting services with docker compose..."
chmod 666 /var/run/docker.sock 2>/dev/null || true
docker compose -f /solution/docker-compose.yml up --build -d

echo "Waiting for app to respond..."
for i in {1..60}; do
  resp=$(curl -s http://localhost:8080/checkdb || true)
  if echo "$resp" | grep -q 'connected'; then
    break
  fi
  sleep 2
done

echo "Final docker state:"
docker ps -a

echo "Done. Try: curl http://localhost:8080/checkdb"
