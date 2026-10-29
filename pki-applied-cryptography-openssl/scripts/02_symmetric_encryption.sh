#!/usr/bin/env bash
# Lab 2 - Random values, Base64 and symmetric encryption (Triple DES, AES-256-CBC).
set -euo pipefail

# Random values
openssl rand -base64 128
openssl rand -hex 32
openssl rand -hex 8
openssl rand -base64 32 > key.txt

# Base64 encoding / decoding
openssl enc -a -in textOriginal.txt -out chiffre64
openssl enc -d -a -in chiffre64 -out decode64.txt

# Triple DES (EDE, CBC mode)
openssl enc -des-ede-cbc -in textOriginal.txt -out chiffredes
openssl enc -d -des-ede-cbc -in chiffredes -out dechiffredes -iter 10000

# AES-256-CBC with salt and key-derivation iterations
openssl enc -aes-256-cbc -in textOriginal.txt -out cryptoAES-256 -iter 10000
openssl enc -d -aes-256-cbc -in cryptoAES-256 -out dechiffreAES256 -iter 10000
openssl enc -aes-256-cbc -salt -in textOriginal.txt -out fichier.enc -iter 10000 -pass pass:secret
openssl enc -d -aes-256-cbc -salt -in fichier.enc -out textOriginal.txt -iter 10000 -pass pass:secret
