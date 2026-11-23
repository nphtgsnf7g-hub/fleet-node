# Multi-stage: the official Xray image is distroless (no /bin/sh), so the
# entrypoint script cannot run in it. Borrow the xray binary (+ geo data)
# into Alpine, which provides sh/sed for the entrypoint.
FROM ghcr.io/xtls/xray-core:latest AS xray
FROM alpine:3.20
COPY --from=xray /usr/local/bin/ /usr/local/bin/
COPY config.json.template /usr/local/etc/xray/config.json.template
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
