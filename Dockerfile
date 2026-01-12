FROM cgr.dev/chainguard/wolfi-base:latest

RUN apk add --no-cache \
    ca-certificates \
    kaniko

ENTRYPOINT ["/usr/bin/executor"]

