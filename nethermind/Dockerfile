FROM debian:stable

ARG VERSION=1.17.3

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends git libsnappy-dev libc6-dev libc6 wget tini apt-transport-https ca-certificates

# Install .NET dependencies
RUN wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb
RUN apt-get update && apt-get install -y --no-install-recommends dotnet-sdk-7.0 aspnetcore-runtime-7.0

RUN git clone -b "${VERSION}" --recursive https://github.com/NethermindEth/nethermind.git && cd nethermind/src/Nethermind && dotnet build Nethermind.sln -c Release

WORKDIR /nethermind

ENV PATH="$PATH:/nethermind/src/Nethermind//Nethermind.Runner/bin/Release/net7.0"

COPY ./entrypoints/entrypoint.sh /entrypoint.sh

# default ports
#
#       rpc    p2p   auth
#        ↓      ↓     ↓ 
EXPOSE  8545  30303  8551

ENTRYPOINT ["/entrypoint.sh"]
CMD ["Nethermind.Runner"]
