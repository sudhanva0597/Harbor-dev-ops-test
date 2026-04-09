#!/usr/bin/env bash
set -e

if ! command -v ansible-playbook >/dev/null 2>&1; then
  echo "Ansible not found. Installing..."
  sudo apt-get update
  sudo apt-get install -y ansible
fi

echo "Running Ansible to install Docker..."
ansible-playbook -i localhost, -c local ansible/install-docker.yml

echo "Starting services with docker compose..."
# run docker in docker group without requiring logout/login
sg docker -c "docker compose up --build -d"

echo "Done. Try: curl http://localhost:8080/checkdb"
