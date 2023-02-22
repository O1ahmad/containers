#!/bin/bash

set -eo pipefail

chain_id=$CHAIN_ID
client_moniker=${GAIA_MONIKER:-gaia-node}
client_home="${GAIA_HOME:-/root/.gaia}"
binary="gaiad"
if [[ $chain_id == "local" ]]; then
    echo "Running client on local DEV network..."
    # if existing genesis config not found, initialize config with at least a required single validator to activate chain
    if [[ ! -f "${client_home}/config/genesis.json" ]]; then
        validator_keyname=${VALIDATOR_KEYNAME:-validator_key_1}
        keyring_backend=${KEYRING_BACKEND:-test}
        initial_balance=${VALIDATOR_INITIAL_BALANCE:-100000000000stake}
        # stake 10% of the validator's token balance by default - note: the validator's balance following setup will only contain
        # the initial balance allocation minus the initial stake amount following setup
        default_stake=$(( $(echo "$initial_balance" | sed 's/[^0-9]*//g') / 10 ))
        initial_stake=${VALIDATOR_INITIAL_STAKE:-$default_stake}

        # execute genesis ledger initialization steps
        $binary init $client_moniker --chain-id $chain_id

        echo "Creating validator key..."
        echo "tube broken pattern gift fire avocado attract bicycle keen tonight awful art girl please index zebra alter wise pigeon erode install ship argue pupil" | $binary keys add $validator_keyname --keyring-backend $keyring_backend --recover
        echo "Done creating validator key..."

        validator_address=$($binary keys show $validator_keyname -a --keyring-backend $keyring_backend)

        echo "Adding validator key to genesis account..."
        $binary add-genesis-account $validator_address $initial_balance

        echo "Generating and collecting genesis tx carrying self delegation..."
        $binary gentx $validator_keyname "${initial_stake}stake" --chain-id $chain_id --keyring-backend $keyring_backend
        $binary collect-gentxs

        # generate sane dev environment configuration
        echo "export MY_VALIDATOR_ADDRESS=$(${binary} keys show ${validator_keyname} -a --keyring-backend ${keyring_backend})" >> ~/.bashrc
    fi
else
    echo "Running client on ${chain_id}..."
    # if existing genesis config not found, execute genesis ledger initialization steps
    if [[ ! -f "${client_home}/config/genesis.json" ]]; then
        echo "Initializing chain."
        $binary init $client_moniker --chain-id $chain_id --home $client_home
    fi
fi

# download genesis config associated with specified network if provided
if [[ ! -z "${CHAIN_GENESIS_CONFIG}" ]]; then
    curl --location ${CHAIN_GENESIS_CONFIG} --output genesis.json.gz
    gzip -d genesis.json.gz
    mv genesis.json "${client_home}/config/genesis.json"
fi

DIR=/docker-entrypoint.d
if [[ -d "$DIR" ]] ; then
  echo "Executing custom entrypoint scripts..."
  /bin/run-parts --exit-on-error "$DIR"
fi

cat $client_home/config/*toml
echo "Starting ${binary} - run arguments: ${RUN_ARGS:-None}"
exec $binary start --home $client_home ${RUN_ARGS}
