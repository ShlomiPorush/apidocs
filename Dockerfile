FROM node:18.15.0-alpine

LABEL maintainer="Shlomi Porush <shlomi@mosesgrp.com>"

ARG ELEMENTS_CLI_VERSION=latest

ENV ELEMENTS_HOSTNAME=0.0.0.0
ENV NODE_ENV=production

COPY . /opt/elements-cli-${ELEMENTS_CLI_VERSION}
COPY favicon /opt/elements-cli-${ELEMENTS_CLI_VERSION}/favicon

RUN set -eux; \
    npm --prefix /opt/elements-cli-${ELEMENTS_CLI_VERSION} install; \
    rm -Rf ~/.npm; \
    ln -s /opt/elements-cli-${ELEMENTS_CLI_VERSION}/elements-cli.mjs /usr/local/bin/elements

WORKDIR /data

# חשוף רק את הפורט הנדרש
EXPOSE 8000

ENTRYPOINT [ "elements" ]