#!/bin/sh
set -eu
: "${UUID:?UUID env is required - generate one per fleet, never share the main UUID publicly}"
PORT="${PORT:-8000}"
WS_PATH="${WS_PATH:-/ws}"
sed -e "s/__PORT__/${PORT}/g" \
    -e "s/__UUID__/${UUID}/g" \
    -e "s|__WS_PATH__|${WS_PATH}|g" \
    /usr/local/etc/xray/config.json.template > /usr/local/etc/xray/config.json
exec xray run -config /usr/local/etc/xray/config.json
