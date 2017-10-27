#!/usr/bin/env bash

trap 'exit 2' ERR INT TERM

if [ -z "${NPM_COMMAND}" ]; then
    NPM_COMMAND="test"
fi

npm install
npm run ${NPM_COMMAND}
