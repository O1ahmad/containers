ARG VERSION=23.1.1

# ******* Stage: setup ******* #
FROM debian:stable AS setup

ARG VERSION
ARG VERSION_SHA

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install --yes --no-install-recommends ca-certificates build-essential git cmake

WORKDIR /nimbus

RUN git clone -b "v${VERSION}" https://github.com/status-im/nimbus-eth2 && cd nimbus-eth2 \
  && make update && make nimbus_beacon_node nimbus_validator_client

# ******* Stage: release ******* #
FROM debian:stable AS release

ARG VERSION
ARG VERSION_SHA

RUN apt update && apt install --yes --no-install-recommends ca-certificates tini

COPY --from=setup /nimbus/nimbus-eth2/build/ /usr/local/bin
COPY ./entrypoints/entrypoint.sh /entrypoint.sh

WORKDIR /nimbus

# default ports
#
#       rest   p2p  (metrics) beacon | validator
#        ↓      ↓           ↓              ↓
EXPOSE  5052   9100        8008           8108

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nimbus_beacon_node"]
