#!/bin/bash
set -eo pipefail

DIR=/docker-entrypoint.d
if [[ -d "$DIR" ]] ; then
  echo "Executing custom entrypoint scripts..."
  /bin/run-parts --exit-on-error "$DIR"
fi

echo "Starting lodestar - run arguments: ${RUN_ARGS:-None}"
cd /lodestar && exec ./lodestar ${RUN_ARGS}