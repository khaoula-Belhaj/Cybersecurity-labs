#!/usr/bin/env bash
# Lab 4 - Hashing, HMAC and DSA digital signatures.
set -euo pipefail

# Hash functions
openssl dgst textOriginal.txt
openssl dgst -md5 textOriginal.txt
openssl dgst -sha1 textOriginal.txt
openssl dgst -sha512 textOriginal.txt

# HMAC (keyed hash)
openssl dgst -sha1 -hmac "salam" textOriginal.txt

# DSA key pair, signature and verification
openssl dsaparam -genkey -out maclePr.pem 1024
openssl dsa -pubout -in maclePr.pem -out pubCle.pem
openssl dgst -sha256 -sign maclePr.pem -out Signature.sign textOriginal.txt
openssl dgst -sha256 -verify pubCle.pem -signature Signature.sign textOriginal.txt
