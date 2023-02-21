ARG VERSION=1.17.0-dd2f2362

# ******* Stage: setup ******* #
FROM debian:stable AS setup

ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends wget unzip apt-transport-https ca-certificates

WORKDIR /nethermind

# Installing Nethermind
RUN wget https://github.com/NethermindEth/nethermind/releases/download/$(echo $VERSION | cut -d '-' -f1)/nethermind-$VERSION-linux-x64.zip \
  && unzip nethermind-$VERSION-linux-x64.zip

# ******* Stage: release ******* #
FROM mcr.microsoft.com/dotnet/runtime:7.0

WORKDIR /nethermind

ENV PATH="$PATH:/nethermind"

RUN apt-get update && apt-get install --yes --no-install-recommends tini apt-transport-https ca-certificates libsnappy-dev libc6-dev libc6

COPY --from=setup /nethermind/ /nethermind
COPY ./entrypoints/entrypoint.sh /entrypoint.sh

# default ports
#
#       rpc    p2p   auth
#        ↓      ↓     ↓ 
EXPOSE  8545  30303  8551

ENTRYPOINT ["/entrypoint.sh"]
CMD ["Nethermind.Runner"]
