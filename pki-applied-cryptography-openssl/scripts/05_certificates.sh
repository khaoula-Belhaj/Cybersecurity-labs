#!/usr/bin/env bash
# Lab 5 - Self-signed certificate and certificate signed by a local CA.
set -euo pipefail

# Self-signed certificate
openssl genrsa -out clefPriveCertificat.key 2048
openssl req -new -key clefPriveCertificat.key -out request.csr
openssl x509 -req -days 365 -in request.csr -signkey clefPriveCertificat.key -out certificate.crt

# Certificate signed by the CA
openssl genrsa -out certificate.key 2048
openssl req -new -key certificate.key -out certificate.csr
openssl x509 -req -in certificate.csr -CA ca.crt -CAkey clefPriveCertificat.key -CAcreateserial -out certificate.crt -days 365 -sha256
openssl x509 -text -noout -in certificate.crt
openssl verify -CAfile ca.crt certificate.crt
