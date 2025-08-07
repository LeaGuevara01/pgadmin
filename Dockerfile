FROM python:3.11-slim

USER root

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
        curl \
        gnupg2 \
        lsb-release \
        libpq-dev \
        build-essential \
        wget \
        libffi-dev \
        libssl-dev \
        libxml2-dev \
        libxslt1-dev \
        libldap2-dev \
        libsasl2-dev \
        libjpeg-dev \
        libkrb5-dev && \
    rm -rf /var/lib/apt/lists/*

# Add PostgreSQL APT repo and install pg_dump 17
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" \
        > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    apt-get install -y postgresql-client-17 && \
    rm -rf /var/lib/apt/lists/*

# Install pgAdmin
RUN pip install pgadmin4==8.6

# Install gunicorn
RUN pip install gunicorn

# Set required environment variables
ENV PGADMIN_LISTEN_PORT=10000
ENV PGADMIN_DEFAULT_EMAIL=admin@admin.com
ENV PGADMIN_DEFAULT_PASSWORD=admin
ENV PGADMIN_CONFIG_LOCAL=True

# Create required directories
RUN mkdir -p /pgadmin4 /var/lib/pgadmin/storage && \
    chmod -R 700 /var/lib/pgadmin

ENV PGADMIN_CONFIG_DIR=/pgadmin4
ENV PGADMIN_DATA_DIR=/var/lib/pgadmin

# Copiar configuración mínima
COPY config_local.py /pgadmin4/config_local.py

# (Opcional) Copiar servers.json para precargar conexiones
COPY servers.json /var/lib/pgadmin/storage/servers.json

# Exponer el puerto
EXPOSE 10000

# Usar el ejecutable directamente
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "pgadmin4.pgAdmin4:app"]
