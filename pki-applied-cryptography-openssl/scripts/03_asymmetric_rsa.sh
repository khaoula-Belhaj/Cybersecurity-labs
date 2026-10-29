#!/usr/bin/env bash
# Lab 3 - RSA key pairs and asymmetric encryption.
set -euo pipefail

# RSA private key, then protect it with AES-256
openssl genrsa -out clefPrive.key 2048
openssl enc -aes-256-cbc -in clefPrive.key -out clefPrive.enc -iter 10000

# RSA parameters and public key
openssl rsa -noout -modulus -in clefPrive.key
openssl rsa -pubout -in clefPrive.key -out clefPublic.key

# Key pair for "Alice": private key protected with AES-128
openssl genrsa -aes128 -out alice_private.pem 1024
openssl rsa -in alice_private.pem -noout -text
openssl rsa -in alice_private.pem -pubout > alice_public.pem

# Encrypt with the public key, decrypt with the private key
openssl pkeyutl -encrypt -inkey alice_public.pem -pubin -in messageSecret.txt -out fichier_secret.enc
openssl pkeyutl -decrypt -inkey alice_private.pem -in fichier_secret.enc -out message_dechiffre.txt
