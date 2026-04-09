## Harbor benchmark test within dev-ops for AI agent and model evaluation
Tested with agent Opencode and model kimi-k2-0905
---
Usage

Export an API key for a model
This project uses openrouter, but could use any provider supported by LiteLLM
```
export OPENROUTER_API_KEY=""
```
Installing harbor
```
uv tool install harbor
```
Running harbor
```
harbor run -p <folder name> -a <agent> -m <model> -k <tries> \
  --mounts-json '[
    {
      "type": "bind",
      "source": "/var/run/docker.sock",
      "target": "/var/run/docker.sock"
    }
  ]'
```
Example using openrouter as provider with opencode agent and kimi-k2-0905 model
```
harbor run -p nestjs-app-setup -a opencode -m openrouter/moonshotai/kimi-k2-0905 -k 10 \
  --mounts-json '[
    {
      "type": "bind",
      "source": "/var/run/docker.sock",
      "target": "/var/run/docker.sock"
    }
  ]'
```
Viewing results
```
harbor view jobs --port 8090
```
Opens a web UI at http://127.0.0.1:8090 with all the job runs, logs and trajectories.

---

Task Description

nestjs-app-setup
An Ai agent is tasked with utilizing Ansible to install Docker, and then create two containers one with Postgres and another with NestJS,
that can talk to each other. The nest js app is also tasked with exposing an endpoint /checkdb that queries postgres with "select 1" to check that everything is successful. 

A pytest script runs separately that verifies both the containers are running and curls the /checkdb endpoint.

---

Results

Test Runs with opencode and kimi-k2-0905
The repo contains folders appropriately titled vague-zero, test-complete-zero, test-fifty, test-seventy, test-hundred
These folders are identical except for the instruction.md file which contains the prompt.
Each of these when run with -k 10 (10 runs of the job) ended with the percentage passing points that correspond to the folder name.

| Number | Name               | Duration | Result | Notes                                                                                                                                                                                         |
| ------ | ------------------ | -------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1      | vague-zero         | 12m40s   | 0/10   | The prompt is vague, and the model fails to create what we ask for.                                                                                                                           |
| 2      | test-complete-zero | 12m58s   | 0/10   | The prompt is a lot more clear and close to creating what we want. Ansible and docker are installed and brought up, but curl fails                                                            |
| 3      | test-fifty         | 11m7s    | 5/10   | The prompt is more defined, and 5 runs pass all 3 tests. The rest pass 2/3 tests.                                                                                                             |
| 4      | test-seventy       | 10m34s   | 7/10   | The prompt is more refined setting expectations. 7 runs pass 3/3 tests, 3 runs pass 2/3 tests.                                                                                                |
| 5      | test-hundred       | 10m40s   | 10/10  | The prompt mentions how it will be tested (specifically curl to /checkdb) and that it expects the response it does. The agent verifies the same in it's loop, and all 10 runs pass 3/3 tests. |

---

Key findings:

- As long as the prompt is not vague, the agent sets up ansible and docker and creates the compose files and brings up the containers.
- With clear mention of curl /checkdb it also manages to set up the endpoint in nest and execute the query and return the result.
- With clearer instruction the duration of the agent took to set up went down slightly.
- Clearer more explicit test mention in the prompt makes the agent better at delivering the required result. This is within expectation.
