import subprocess
import requests

BASE_URL = "http://localhost:8080"

def test_checkdb_endpoint():
    response = requests.get(f"{BASE_URL}/checkdb")
    assert response.status_code == 200
    data = response.json()
    assert data["connected"] is True
    assert data["result"] == [{"status": 1}]

def test_docker_containers_running():
    result = subprocess.run(
        ["docker", "ps", "--format", "{{.Names}}"],
        capture_output=True,
        text=True,
    )
    containers = result.stdout.strip().splitlines()
    assert "app-postgres" in containers
    assert "app-nestjs" in containers

def test_exposed_ports():
    result = subprocess.run(
        ["docker", "ps", "--format", "{{.Names}} {{.Ports}}"],
        capture_output=True,
        text=True,
    )
    lines = result.stdout.strip().splitlines()
    port_map = {}
    for line in lines:
        parts = line.split(" ", 1)
        if len(parts) == 2:
            port_map[parts[0]] = parts[1]

    assert "app-postgres" in port_map
    assert "5432" in port_map["app-postgres"]

    assert "app-nestjs" in port_map
    assert "8080" in port_map["app-nestjs"]
