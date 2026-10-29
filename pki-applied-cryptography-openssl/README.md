# PKI & Applied Cryptography with OpenSSL

Building a private **Public Key Infrastructure** and practising the core cryptographic primitives behind TLS — symmetric and asymmetric encryption, hashing, HMAC and digital signatures — with **OpenSSL**.

> Academic labs — Cryptography module, ENSA Fez (GSCSI), 2024–2025.

![OpenSSL](https://img.shields.io/badge/OpenSSL-PKI-721412) ![X.509](https://img.shields.io/badge/X.509-certificates-blue) ![Crypto](https://img.shields.io/badge/RSA%20%7C%20DSA%20%7C%20AES%20%7C%20SHA--2-grey)

---

## 1. Private PKI: certificate authority and server certificate

```bash
# Root CA: 4096-bit RSA key + self-signed certificate (10 years)
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days 3650 -out ca.crt

# Server: private key + Certificate Signing Request (CSR)
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr

# The CA signs the server certificate
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 365 -sha256

# Inspection, chain of trust, format conversion
openssl x509 -in server.crt -text -noout
openssl verify -CAfile ca.crt server.crt
openssl x509 -in server.crt -outform der -out server.der
```

**Outcome:** a working chain of trust (root CA → server certificate) verified with `openssl verify`, and certificates converted between PEM and DER.

## 2. Symmetric encryption (AES, DES)

```bash
openssl enc -aes-256-cbc -salt -in textOriginal.txt -out fichier.enc -iter 10000
openssl enc -d -aes-256-cbc -salt -in fichier.enc -out textOriginal.txt -iter 10000
```

AES-256 in CBC mode with a salt and key derivation iterations; DES encryption and decryption also practised (a legacy algorithm, no longer considered secure).

## 3. Asymmetric encryption (RSA)

- Generated RSA key pairs, including a private key **protected with AES-128** (`genrsa -aes128`).
- Derived the public key, encrypted a message with the public key and decrypted it with the private key.
- Inspected the RSA parameters (modulus, exponents, primes).

## 4. Hashing, HMAC and digital signatures

```bash
openssl dgst -sha256 textOriginal.txt                      # hash
openssl dgst -sha1 -hmac "<key>" textOriginal.txt          # HMAC (keyed hash)
openssl dsaparam -genkey -out maclePr.pem 1024                               # DSA key
openssl dsa -pubout -in maclePr.pem -out pubCle.pem                           # public key
openssl dgst -sha256 -sign maclePr.pem -out Signature.sign textOriginal.txt   # sign
openssl dgst -sha256 -verify pubCle.pem -signature Signature.sign textOriginal.txt # verify
```

Integrity (MD5, SHA-1, SHA-256, SHA-512), authenticity (HMAC) and non-repudiation (**DSA** signatures), plus Base64 encoding/decoding.

## Concepts covered

| Concept | Purpose |
|---|---|
| Certificate Authority (CA) | Trusted third party that signs certificates |
| CSR | Request containing the public key and identity, sent to the CA |
| X.509 | Standard certificate format used by TLS/HTTPS |
| Chain of trust | Verifying a certificate back to a trusted root |
| AES / DES | Symmetric encryption (same key both ways) |
| RSA | Asymmetric encryption (key pair) |
| DSA | Digital signatures |
| SHA-2 / HMAC | Integrity / integrity + authenticity |

## Skills demonstrated

OpenSSL · PKI · X.509 · RSA · AES · SHA-2 · HMAC · digital signatures · TLS foundations

## Scripts

All commands executed during the labs, grouped by topic in [`scripts/`](scripts/):

| Script | Topic |
|---|---|
| [`01_private_pki.sh`](scripts/01_private_pki.sh) | Root CA, CSR, CA-signed certificate, chain verification |
| [`02_symmetric_encryption.sh`](scripts/02_symmetric_encryption.sh) | Random values, Base64, Triple DES, AES-256-CBC |
| [`03_asymmetric_rsa.sh`](scripts/03_asymmetric_rsa.sh) | RSA key pairs, protected private key, public-key encryption |
| [`04_hashing_hmac_signatures.sh`](scripts/04_hashing_hmac_signatures.sh) | Hashing, HMAC, DSA signatures |
| [`05_certificates.sh`](scripts/05_certificates.sh) | Self-signed and CA-signed certificates |

## Documentation

- [Full report (French)](docs/report-openssl-pki.pdf)

---

**Author:** Khaoula Belhaj — final-year engineering student, Communicating Systems & Computer Security, ENSA Fez · [LinkedIn](https://linkedin.com/in/khaoula-belhaj-1999163a6)
