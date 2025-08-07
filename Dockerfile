FROM dpage/pgadmin4:latest

USER root

RUN apt-get update && apt-get install -y postgresql-client

USER pgadmin
