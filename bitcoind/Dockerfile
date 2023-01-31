ARG VERSION=24.0.1

# ******* Stage: setup ******* #
FROM debian:stable AS setup

ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates

WORKDIR /bitcoind

RUN wget "https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz" \
    && tar -xvf bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz

# ******* Stage: release ******* #
FROM debian:stable

ARG VERSION

COPY --from=setup /bitcoind/bitcoin-${VERSION}/bin /usr/local/bin
COPY ./entrypoints/entrypoint.sh /entrypoint.sh

# default ports
#
#       rpc    p2p   zmq
#        ↓      ↓     ↓
EXPOSE 8332   18446  8334

ENTRYPOINT ["/entrypoint.sh"]
