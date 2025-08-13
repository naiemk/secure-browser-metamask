FROM mrcolorrain/vnc-browser:latest

USER root

# Set display number for Xvfb
ENV DISPLAY=:0

# Install tools to fetch MetaMask extension
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Download the MetaMask extension
RUN mkdir -p /opt/metamask \
    && wget -qO /tmp/metamask.zip https://github.com/MetaMask/metamask-extension/releases/latest/download/metamask-chrome.zip \
    && unzip /tmp/metamask.zip -d /opt/metamask \
    && rm /tmp/metamask.zip

# Startup script that launches the browser with MetaMask
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Static page for decrypting private keys
COPY keys.html /keys.html

EXPOSE 5900

CMD ["/usr/local/bin/start.sh"]
