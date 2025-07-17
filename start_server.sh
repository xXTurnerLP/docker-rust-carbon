#!/bin/bash

cd /home/container

MODIFIED_STARTUP=$(eval echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g') # replaces {{var}} to ${var} (so bash can understand it)

printf "Running server with args: '$(eval echo ${MODIFIED_STARTUP})'\n"

./RustDedicated -batchmode $(eval echo ${MODIFIED_STARTUP})