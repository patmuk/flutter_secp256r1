import 'dart:typed_data';

import 'extension.dart';
import 'der.dart';
import 'types.dart';

class P256KeyPair extends KeyPair {
  const P256KeyPair({required super.publicKey, required super.secretKey});

  List<String> toJson() {
    return [publicKey.toDer().toHex(), secretKey.toHex()];
  }
}

typedef SigningFunc = Future<Uint8List> Function(
  Uint8List blob,
  Uint8List seed,
);

typedef VerifyFunc = Future<bool> Function(
  Uint8List blob,
  Uint8List signature,
  P256PublicKey publicKey,
);

class P256PublicKey implements PublicKey {
  P256PublicKey(this.rawKey) : assert(rawKey.isNotEmpty);

  factory P256PublicKey.fromRaw(BinaryBlob rawKey) {
    return P256PublicKey(rawKey);
  }

  factory P256PublicKey.fromDer(BinaryBlob derKey) {
    return P256PublicKey(P256PublicKey.derDecode(derKey));
  }

  factory P256PublicKey.from(PublicKey key) {
    return P256PublicKey.fromDer(key.toDer());
  }

  final BinaryBlob rawKey;
  late final derKey = P256PublicKey.derEncode(rawKey);

  static Uint8List derEncode(BinaryBlob publicKey) {
    return bytesWrapDer(publicKey, oidP256);
  }

  static Uint8List derDecode(BinaryBlob publicKey) {
    return bytesUnwrapDer(publicKey, oidP256);
  }

  @override
  Uint8List toDer() => derKey;

  Uint8List toRaw() => rawKey;
}
