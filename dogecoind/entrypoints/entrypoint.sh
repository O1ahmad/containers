#!/bin/bash
set -eo pipefail

DIR=/docker-entrypoint.d
if [[ -d "$DIR" ]] ; then
  echo "Executing custom entrypoint scripts..."
  /bin/run-parts --exit-on-error "$DIR"
fi

echo "Starting dogecoind - run arguments: ${RUN_ARGS:-None}"
exec dogecoind ${RUN_ARGS}
