#!/bin/bash
set -e

# Validate environment variables
if [ -z "$DOMAIN_NAMES" ]; then
  echo "[mkcert] ERROR: DOMAIN_NAMES environment variable not set."
  exit 1
fi

if [ -z "$CERT_DIR" ]; then
  echo "[mkcert] ERROR: CERT_DIR environment variable not set."
  exit 1
fi

# Ensure output directory exists
mkdir -p "$CERT_DIR"

echo "[mkcert] Installing local CA if needed..."
mkcert -install

echo "[mkcert] Generating certificates for: $DOMAIN_NAMES"
mkcert -cert-file "$CERT_DIR/local.crt" -key-file "$CERT_DIR/local.key" $DOMAIN_NAMES

echo "[mkcert] Certificates updated at $(date)"
