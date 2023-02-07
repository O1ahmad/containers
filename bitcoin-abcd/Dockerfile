ARG VERSION=0.26.11

# ******* Stage: setup ******* #
FROM debian:stable AS setup

ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates

WORKDIR /bitcoin-abcd

RUN wget "https://github.com/Bitcoin-ABC/bitcoin-abc/releases/download/v${VERSION}/bitcoin-abc-${VERSION}-x86_64-linux-gnu.tar.gz" \
    && tar -xvf bitcoin-abc-${VERSION}-x86_64-linux-gnu.tar.gz

# ******* Stage: release ******* #
FROM debian:stable

ARG VERSION

RUN apt-get update && apt-get install --yes --no-install-recommends tini

COPY --from=setup /bitcoin-abcd/bitcoin-abc-${VERSION}/bin /usr/local/bin
COPY ./entrypoints/entrypoint.sh /entrypoint.sh

# default ports
#
#       rpc    p2p   zmq
#        ↓      ↓     ↓
EXPOSE 8332   18446  8334

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bitcoind"]
