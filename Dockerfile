FROM dpage/pgadmin4:8.6

USER root

RUN which apk || which apt-get || which yum || which dnf || which zypper
