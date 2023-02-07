ARG VERSION=v1.4.1

# ******* Stage: setup ******* #
FROM node:18-buster AS setup

ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install --yes --no-install-recommends \
  ca-certificates \
  git \
  g++ \
  make \
  python3 \
  tini

WORKDIR /

RUN git clone --depth 1 --branch ${VERSION} https://github.com/ChainSafe/lodestar.git
RUN cd lodestar && yarn install --ignore-optional && yarn run build

ENV PATH="$PATH:/lodestar"

COPY ./entrypoints/entrypoint.sh /entrypoint.sh

WORKDIR /lodestar

# default ports
#
#       rpc    p2p  metrics
#        ↓      ↓     ↓
EXPOSE 9596   9000  8008

ENTRYPOINT ["/entrypoint.sh"]
CMD ["lodestar"]
