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

This project has been forked from [AstroxNetwork/flutter_secp256r1](https://github.com/AstroxNetwork/flutter_secp256r1) to remove the dependency on `agent_dart` and 'Flutter_rust_bridge'. ([Why!](https://github.com/AstroxNetwork/flutter_secp256r1/issues/9))
Doing so I removed the en/decrypt functions as well, as they are not done on the secure computing environment anyways.
If you want to encrypt your data, `getSharedSecret`, use a `KDF` algorithm to compute a symmetric key and encrypt your data with it. 
This is more performant as well.
Hint: Use an ephemeral asymetric key pair for perfect forward security instead of the others public key alone.

## Methods

- `SecureP256.getPublicKey`
- `SecureP256.sign`
- `SecureP256.verify`
- `SecureP256.getSharedSecret`
