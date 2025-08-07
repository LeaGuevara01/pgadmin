FROM dpage/pgadmin4:8.6

USER root

# Instala pg_dump 17 y dependencias
RUN apt-get update && \
    apt-get install -y curl gnupg2 lsb-release && \
    curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    apt-get install -y postgresql-client-17 && \
    rm -rf /var/lib/apt/lists/*

# Copiamos el servers.json al path correcto
COPY servers.json /var/lib/pgadmin/storage/insanityscream01_gmail.com/servers.json

# Copiamos config_local.py para que pgAdmin escuche en 0.0.0.0 y puerto correcto
COPY config_local.py /pgadmin4/config_local.py

# Damos permisos adecuados
RUN chown -R pgadmin:pgadmin /var/lib/pgadmin/storage /pgadmin4/config_local.py

USER pgadmin
