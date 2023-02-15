ARG VERSION=23.1.1_1ea102b0

# ******* Stage: setup ******* #
FROM debian:stable AS setup

ARG VERSION
ARG VERSION_SHA

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install --yes --no-install-recommends ca-certificates wget

WORKDIR /nimbus

RUN wget https://github.com/status-im/nimbus-eth2/releases/download/v$(echo $VERSION | cut -d '_' -f1)/nimbus-eth2_Linux_amd64_${VERSION}.tar.gz \
  && tar -xzf nimbus-eth2_Linux_amd64_${VERSION}.tar.gz

# ******* Stage: release ******* #
FROM debian:stable AS release

ARG VERSION
ARG VERSION_SHA

RUN apt update && apt install --yes --no-install-recommends ca-certificates tini

COPY --from=setup /nimbus/nimbus-eth2_Linux_amd64_${VERSION}/build/ /usr/local/bin
COPY ./entrypoints/entrypoint.sh /entrypoint.sh

WORKDIR /nimbus

# default ports
#
#       rest   p2p  (metrics) beacon | validator
#        ↓      ↓           ↓              ↓
EXPOSE  5052   9100        8008           8108

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nimbus_beacon_node"]
