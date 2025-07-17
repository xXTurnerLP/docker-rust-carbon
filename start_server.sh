cd /home/container

printf "Running server with args: '${MODIFIED_STARTUP}'\n"

./RustDedicated -batchmode -logfile 2>&1 "${MODIFIED_STARTUP}"