ARG VERSION=1.14.6

# ******* Stage: setup ******* #
FROM debian:stable AS setup

ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates

WORKDIR /dogecoind

RUN wget "https://github.com/dogecoin/dogecoin/releases/download/v${VERSION}/dogecoin-${VERSION}-x86_64-linux-gnu.tar.gz" \
    && tar -xvf dogecoin-${VERSION}-x86_64-linux-gnu.tar.gz

# ******* Stage: release ******* #
FROM debian:stable

ARG VERSION

RUN apt-get update && apt-get install --yes --no-install-recommends tini

COPY --from=setup /dogecoind/dogecoin-${VERSION}/bin /usr/local/bin
COPY ./entrypoints/entrypoint.sh /entrypoint.sh

# default ports
#
#       rpc   zmq  p2p
#        ↓     ↓     ↓
EXPOSE 22555 28334 22556

ENTRYPOINT ["/entrypoint.sh"]
CMD ["dogecoind"]
