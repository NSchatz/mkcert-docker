FROM alpine:latest

# Install dependencies
RUN apk add --no-cache openssl ca-certificates bash curl \
    && update-ca-certificates

# Detect architecture for mkcert binary
# Map Alpine's `uname -m` to mkcert's release naming
RUN ARCH=$(case "$(uname -m)" in \
        x86_64) echo "amd64" ;; \
        aarch64) echo "arm64" ;; \
        armv7l) echo "arm" ;; \
        *) echo "amd64" ;; \
    esac) && \
    echo "Downloading mkcert for architecture: $ARCH" && \
    curl -L -o /usr/local/bin/mkcert \
      "https://github.com/FiloSottile/mkcert/releases/latest/download/mkcert-v1.4.4-linux-$ARCH" && \
    chmod +x /usr/local/bin/mkcert

WORKDIR /app

VOLUME ["/root/.local/share/mkcert", "/certs"]

ENV DOMAIN_NAMES="*.schatz localhost 127.0.0.1 ::1"
ENV CERT_DIR="/certs"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
