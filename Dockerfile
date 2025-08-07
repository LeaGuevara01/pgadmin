FROM python:3.11-slim

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

# Install pgAdmin (from PyPI)
RUN pip install pgadmin4==8.6

# Set environment variables for pgAdmin
ENV PGADMIN_LISTEN_PORT=80
ENV PGADMIN_DEFAULT_EMAIL=admin@admin.com
ENV PGADMIN_DEFAULT_PASSWORD=admin

# Create required directories
RUN mkdir -p /var/lib/pgadmin && \
    mkdir -p /pgadmin4

ENV PGADMIN_CONFIG_DIR=/pgadmin4
ENV PGADMIN_DATA_DIR=/var/lib/pgadmin

# Expose port
EXPOSE 80

# Launch pgAdmin
CMD ["python", "-m", "pgadmin4"]
