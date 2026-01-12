FROM cgr.dev/chainguard/wolfi-base:latest

RUN apk add --no-cache \
      ca-certificates \
      kaniko \
    && mkdir -p /workspace /kaniko

WORKDIR /workspace

ENTRYPOINT ["/usr/bin/executor"]

