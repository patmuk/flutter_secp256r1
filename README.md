# Secure P256 Flutter plugin

<!-- [![Pub](https://img.shields.io/pub/v/secp256r1?color=42a012&include_prereleases&logo=dart&style=flat-square)](https://pub.dev/packages/secp256r1) -->
[![License](https://img.shields.io/github/license/AstroxNetwork/flutter_secp256r1?style=flat-square)](https://github.com/AstroxNetwork/flutter_secp256r1/blob/main/LICENSE)

A Flutter plugin that support secp256r1 by *StrongBox & Keystore on Android* and *Secure Enclave on iOS*.

It offers for both:
- key generation
- getting the public key (the private key can never be obtained!)
- signing
- validating a signature
- computing a Shared Secret with the other's public key

These operations run on the secure enclave of the respective platform.
For this Flutter Method Channels are used, the API interacting code is written in `Android/kotlin` and `iOS/Swift`.

The folder `lib/utils/` contains many converter functions, however, only a few in `lib/extension.dart` are actually used. For convinience the rest is left here from the fork but can be removed.

This project has been forked from [AstroxNetwork/flutter_secp256r1](https://github.com/AstroxNetwork/flutter_secp256r1) to remove the dependency on `agent_dart` and 'Flutter_rust_bridge'.

## Methods

- `SecureP256.getPublicKey`
- `SecureP256.sign`
- `SecureP256.verify`
- `SecureP256.getSharedSecret`
