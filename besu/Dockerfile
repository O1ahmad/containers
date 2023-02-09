ARG VERSION=22.10.3

# ******* Stage: setup ******* #
FROM openjdk:18-jdk-buster AS setup

ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates tini

WORKDIR /besu

# Installing Besu
RUN wget -c https://hyperledger.jfrog.io/hyperledger/besu-binaries/besu/${VERSION}/besu-${VERSION}.tar.gz \
    && tar -xvf besu-${VERSION}.tar.gz
ENV PATH="$PATH:/besu/besu-${VERSION}/bin/"

COPY ./entrypoints/entrypoint.sh /entrypoint.sh

# default ports
#
#       rpc    ws  graphql p2p   auth  metrics
#        ↓     ↓     ↓      ↓     ↓     ↓
EXPOSE  8545  8546  8547  30303  8551  9545

ENTRYPOINT ["/entrypoint.sh"]
CMD ["besu"]
