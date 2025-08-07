FROM dpage/pgadmin4:8.6

USER root

# Install curl, gnupg, and other dependencies before adding PostgreSQL repo
RUN apt-get update && \
    apt-get install -y curl gnupg2 lsb-release && \
    curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    apt-get install -y postgresql-client-17 && \
    rm -rf /var/lib/apt/lists/*

USER pgadmin
