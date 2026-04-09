Use Ansible to install Docker and then use it to bring up containers with the services postgres and a nestjs app.
The postgres container should be named app-postgres and expose default port.
The nestjs container should be named app-nestjs and expose port 8080 outside.
The nestjs app should expose a GET /checkdb endpoint that runs a select 1 query.
