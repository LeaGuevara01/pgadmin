FROM dpage/pgadmin4:8.6

# Add PostgreSQL 17 client tools (Debian-based)
RUN curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo "deb http://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
  && apt-get update \
  && apt-get install -y postgresql-client-17 \
  && rm -rf /var/lib/apt/lists/*
