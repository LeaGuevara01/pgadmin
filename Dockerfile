FROM python:3.11-slim

USER root

RUN apt-get update && \
    apt-get install -y curl gnupg2 lsb-release postgresql-client-17 && \
    rm -rf /var/lib/apt/lists/*

RUN pip install pgadmin4==8.6

COPY servers.json /pgadmin4/servers.json
COPY config_local.py /pgadmin4/config_local.py

ENV PGADMIN_CONFIG_DIR=/pgadmin4
ENV PGADMIN_DATA_DIR=/var/lib/pgadmin

RUN mkdir -p /var/lib/pgadmin && chown -R 1000:1000 /var/lib/pgadmin /pgadmin4

USER 1000

EXPOSE 10000

CMD ["python3", "-m", "pgadmin4"]
