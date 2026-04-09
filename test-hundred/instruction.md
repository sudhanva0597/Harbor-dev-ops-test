I want to setup a docker container with the following requirements:
   - Install Ansible if not present
   - Use Ansible to install Docker and Docker Compose
   - Ensure Docker service is started and enabled
   - Add the current user to the docker group
   - Ensure Docker commands can run immediately without requiring logout/login (no sudo for docker commands)
After Docker is installed,
   - Build and run a docker-compose.yml setup
The Docker Compose setup must include:
   - A PostgreSQL container
   - A NestJS application container
NestJS app requirements:
   - Expose endpoint: GET /checkdb on port 8080
   - Connect to PostgreSQL using environment variables
   - Execute SELECT 1; and return the result
   - Handle DB startup race conditions (retry connection)
Project structure should be created automatically:
   - setup.sh
   - ansible/install-docker.yml
   - docker-compose.yml
   - nest-app/ with all required files (Dockerfile, package.json, tsconfig, source code)
Constraints:
   - No manual steps after running ./setup.sh
   - No sudo required for running Docker commands
   - Must work on a clean Ubuntu system
   - Avoid fragile Ansible features (ensure compatibility with older versions)
   - Avoid apt locking issues (handle package manager contention safely)
Final result:
   - curl http://localhost:8080/checkdb should return [{"?column?":1}]
Provide all files with correct content.
