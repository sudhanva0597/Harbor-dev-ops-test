Use Ansible to install Docker. After installation, use Ansible to bring up a Docker Compose stack with two services — Postgres (latest) and a NestJS app.
Container requirements  
The Postgres container should be named something like app-postgres and expose the default database port.  
The NestJS container should be named something like app-nestjs and expose its HTTP port on 8080.
The Compose setup should ensure the NestJS service waits for Postgres to be available before starting.
NestJS app requirements  
Create a minimal NestJS app with a GET /checkdb endpoint that:
Runs a simple query like SELECT 1; against Postgres.  
Returns a JSON response showing the result of the query and whether the connection worked.
