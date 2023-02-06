ARG VERSION=0.21.2.1

# ******* Stage: setup ******* #
FROM debian:stable AS setup

ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates

WORKDIR /litecoind

RUN wget "https://github.com/litecoin-project/litecoin/releases/download/v${VERSION}/litecoin-${VERSION}-x86_64-linux-gnu.tar.gz" \
    && tar -xvf litecoin-${VERSION}-x86_64-linux-gnu.tar.gz

# ******* Stage: release ******* #
FROM debian:stable

ARG VERSION

COPY --from=setup /litecoind/litecoin-${VERSION}/bin /usr/local/bin
COPY ./entrypoints/entrypoint.sh /entrypoint.sh

# default ports
#
#       rpc    p2p   zmq
#        ↓      ↓     ↓
EXPOSE 9332   8333  28332

ENTRYPOINT ["/entrypoint.sh"]
