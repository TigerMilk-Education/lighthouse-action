# Base image built from Dockerfile.base (Chrome Stable + Node LTS)
FROM browserless/chrome

LABEL "com.github.actions.name"="Lighthouse Audit"
LABEL "com.github.actions.description"="Run tests on a webpage via Google's Lighthouse tool"
LABEL "com.github.actions.icon"="check-square"
LABEL "com.github.actions.color"="yellow"

LABEL version="0.4.2"

# Download latest Lighthouse build from npm
# Cache bust to ensure latest version when building the image
ARG CACHEBUST=1
USER root
RUN apt-get update && apt-get install -y sudo curl git jq bc
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - && sudo apt-get install -y nodejs
RUN npm install -g lighthouse

# Disable Lighthouse error reporting to prevent prompt
ENV CI=true

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
