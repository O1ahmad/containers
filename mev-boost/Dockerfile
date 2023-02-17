ARG VERSION=1.4.0

# ******* Stage: setup ******* #
FROM golang:1.18.0-buster AS setup

ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /go/src

RUN apt update && apt install -y --no-install-recommends git make

RUN git clone -b "v${VERSION}" https://github.com/flashbots/mev-boost && cd mev-boost && make build

# ******* Stage: release ******* #
FROM debian:stable

COPY --from=setup /go/src/mev-boost/mev-boost /usr/local/bin
COPY ./entrypoints/entrypoint.sh /entrypoint.sh

RUN apt update && apt install -y --no-install-recommends ca-certificates tini

# default ports
#
#       rpc
#        ↓
EXPOSE 18550

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mev-boost"]
