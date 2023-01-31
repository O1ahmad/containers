#!/bin/bash
set -eo pipefail

DIR=/docker-entrypoint.d
if [[ -d "$DIR" ]] ; then
  echo "Executing custom entrypoint scripts in $DIR"
  /bin/run-parts --exit-on-error "$DIR"
fi

echo "Starting avalanchego, with arguments: ${RUN_ARGS:-None}"
exec avalanchego ${RUN_ARGS}
