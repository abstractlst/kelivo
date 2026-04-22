#!/usr/bin/env bash
set -euo pipefail

if [ "${USE_XVFB:-0}" = "1" ]; then
  export DISPLAY="${DISPLAY:-:99}"
  XVFB_WHD="${XVFB_WHD:-1280x720x24}"
  Xvfb "${DISPLAY}" -screen 0 "${XVFB_WHD}" -nolisten tcp -ac &
  XVFB_PID=$!
  trap 'kill ${XVFB_PID} >/dev/null 2>&1 || true' EXIT
fi

if [ -z "${DISPLAY:-}" ]; then
  echo "DISPLAY is not set. For GUI mode, pass -e DISPLAY and mount /tmp/.X11-unix."
  echo "Or run with -e USE_XVFB=1 for headless software-rendered mode."
  exit 1
fi

exec /opt/kelivo/kelivo "$@"
