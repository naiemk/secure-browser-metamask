# secure-browser-metamask

A docker image to run MetaMask and a Chromium browser in an isolated
environment. The container is based on the `mrcolorrain/vnc-browser` image and
preloads the MetaMask extension. It exposes a VNC server so you can interact with the
browser without sharing your host credentials.

## Build

```bash
docker build -t secure-browser-metamask .
```

## Run

```bash
docker run -p 5900:5900 secure-browser-metamask
```

Then connect your VNC client to `localhost:5900` and configure MetaMask or
browse as needed. Once the container is stopped everything in the session is
lost.

## Import encrypted keys

Create a `keys.json` (or `.env`) file containing your encrypted private keys
and mount it into the container:

```bash
docker run -p 5900:5900 -v /path/to/keys.json:/keys.json:ro secure-browser-metamask
```

On start the browser opens `keys.html` which loads the encrypted keys, asks for
a password, and displays the decrypted keys for you to copy into MetaMask.
