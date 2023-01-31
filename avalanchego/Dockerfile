ARG VERSION=v1.9.7

# ******* Stage: setup ******* #
FROM debian:stable AS setup

ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates

WORKDIR /avalanche

RUN wget "https://github.com/ava-labs/avalanchego/releases/download/${VERSION}/avalanchego-linux-amd64-${VERSION}.tar.gz" \
    && tar -xvf avalanchego-linux-amd64-${VERSION}.tar.gz

# ******* Stage: release ******* #
FROM debian:stable

ARG VERSION

COPY --from=setup /avalanche/avalanchego-${VERSION}/ /usr/local/bin
COPY ./entrypoints/entrypoint.sh /entrypoint.sh

# default ports
#
#      rpc   p2p
#       ↓     ↓
EXPOSE 9650 9651

ENTRYPOINT ["/entrypoint.sh"]
