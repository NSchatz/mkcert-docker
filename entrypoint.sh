#!/bin/bash
set -e

echo "[mkcert] Installing local CA if needed..."
mkcert -install

if [ -z "$DOMAIN_NAMES" ]; then
  echo "[mkcert] ERROR: DOMAIN_NAMES environment variable not set."
  exit 1
fi

echo "[mkcert] Generating certificates for: $DOMAIN_NAMES"
mkcert -cert-file "$CERT_DIR/local.crt" -key-file "$CERT_DIR/local.key" $DOMAIN_NAMES

echo "[mkcert] Certificates updated at $(date)"
