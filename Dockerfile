FROM   debian:bookworm-backports

LABEL  org.opencontainers.image.vendor="Open Digital Radio"
LABEL  org.opencontainers.image.description="DAB/DAB+ Multiplexer"
LABEL  org.opencontainers.image.authors="colisee@hotmail.com"

EXPOSE 9001-9016
EXPOSE 9201
EXPOSE 12720-12722
ENTRYPOINT ["odr-dabmux", "/config/odr-dabmux.inf"]

ENV    DEBIAN_FRONTEND=noninteractive
RUN    apt-get update ;\
       apt-get upgrade --yes ;\
       apt-get install --yes odr-dabmux ;\
       rm -rf /var/lib/apt/lists/* ;\
       useradd --create-home odr

USER   odr
