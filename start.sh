#!/usr/bin/env bash
set -e

BROWSER=$(command -v chromium-browser || command -v chromium || command -v google-chrome || command -v google-chrome-stable)

# Start virtual framebuffer
Xvfb :0 -screen 0 1920x1080x24 &
XVFB_PID=$!

# Start a window manager so the browser has something to talk to
fluxbox &

# Start VNC server exposing the Xvfb display
x11vnc -display :0 -nopw -forever -shared -geometry 1920x1080 &

# Launch the browser with the MetaMask extension
"$BROWSER" \
    --no-sandbox \
    --disable-dev-shm-usage \
    --load-extension=/opt/metamask \
    file:///keys.html &

wait $XVFB_PID
