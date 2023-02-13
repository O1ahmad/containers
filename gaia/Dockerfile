ARG VERSION=8.0.0

# ******* Stage: setup ******* #
FROM golang:1.18.0-buster AS setup

ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /go/src

RUN apt update && apt install -y --no-install-recommends git make

RUN git clone -b "v${VERSION}" https://github.com/cosmos/gaia && cd gaia && make install

# ******* Stage: release ******* #
FROM debian:stable

ENV CHAIN_ID=local

COPY --from=setup /go/bin/ /usr/local/bin
COPY ./entrypoints/entrypoint.sh /entrypoint.sh

# default ports
#
#       p2p   rpc  grpc  grpc-web   abci   metrics  light-client
#        ↓     ↓     ↓      ↓         ↓       ↓          ↓
EXPOSE 26656 26657 9090    9091     26658   26660      1317

ENTRYPOINT ["/entrypoint.sh"]
