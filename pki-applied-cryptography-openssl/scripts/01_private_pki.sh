#!/usr/bin/env bash
# Lab 1 - Private PKI with OpenSSL: root CA, server CSR, CA-signed certificate.
# Commands executed during the lab (originally on Windows with OpenSSL-Win64).
set -euo pipefail

openssl version -a

# Root certificate authority: 4096-bit RSA key + self-signed certificate (10 years)
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days 3650 -out ca.crt
openssl x509 -in ca.crt -text -noout

# Server key and Certificate Signing Request
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr

# The CA signs the server certificate
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 365 -sha256

# Inspection, chain of trust and PEM -> DER conversion
openssl x509 -in server.crt -text -noout
openssl verify -CAfile ca.crt server.crt
openssl x509 -in server.crt -outform der -out server.der
