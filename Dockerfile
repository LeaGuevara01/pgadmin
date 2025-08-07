FROM python:3.11-slim

USER root

# Instalar herramientas base
RUN apt-get update && \
    apt-get install -y \
        curl \
        gnupg \
        lsb-release \
        ca-certificates \
        build-essential \
        libpq-dev

# Agregar repo oficial de PostgreSQL y cliente 17
RUN curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/pgdg.gpg && \
    echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    apt-get install -y postgresql-client-17 && \
    rm -rf /var/lib/apt/lists/*

# Instalar pgAdmin 4 desde pip
RUN pip install pgadmin4==8.6

# Variables de entorno
ENV PGADMIN_CONFIG_DIR=/pgadmin4
ENV PGADMIN_DATA_DIR=/var/lib/pgadmin
ENV PGADMIN_LISTEN_PORT=10000
ENV PGADMIN_DEFAULT_EMAIL=admin@admin.com
ENV PGADMIN_DEFAULT_PASSWORD=admin

# Crear carpetas necesarias
RUN mkdir -p /pgadmin4 /var/lib/pgadmin && \
    chmod -R 700 /pgadmin4 /var/lib/pgadmin && \
    chown -R 1000:1000 /pgadmin4 /var/lib/pgadmin
