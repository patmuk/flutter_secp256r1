import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'extension.dart';

/// A Key Pair, containing a secret and public key.
@immutable
abstract class KeyPair {
  const KeyPair({required this.secretKey, required this.publicKey});

  final BinaryBlob secretKey;
  final PublicKey publicKey;
}

@immutable
abstract class PublicKey {
  const PublicKey();

  // Get the public key bytes encoded with DER.
  DerEncodedBlob toDer();
}

// enum FetchMethod {
//   get,
//   head,
//   post,
//   put,
//   delete,
//   connect,
//   options,
//   trace,
//   patch,
// }

// enum RequestStatusResponseStatus {
//   received,
//   processing,
//   replied,
//   rejected,
//   unknown,
//   done;

//   factory RequestStatusResponseStatus.fromName(String value) {
//     return values.singleWhere((e) => e.name == value);
//   }
// }

// enum BlobType { binary, der, nonce, requestId }

// @immutable
// abstract class BaseBlob {
//   const BaseBlob(
//     Uint8List buffer,
//     this.blobType,
//     this.blobName,
//   ) : _buffer = buffer;

//   final Uint8List _buffer;
//   final BlobType blobType;
//   final String blobName;

//   Uint8List get buffer => _buffer;

//   int get byteLength;
// }

typedef BinaryBlob = Uint8List;
typedef DerEncodedBlob = BinaryBlob;
// typedef Nonce = BinaryBlob;
// typedef RequestId = BinaryBlob;

// extension ExtBinaryBlob on BinaryBlob {
//   String get name => '__BLOB';

//   BlobType get blobType => BlobType.binary;

//   int get byteLength => lengthInBytes;

//   static Uint8List from(Uint8List other) => Uint8List.fromList(other);
// }

// BinaryBlob blobFromBuffer(ByteBuffer b) {
//   return BinaryBlob.fromList(b.asUint8List());
// }

// BinaryBlob blobFromUint8Array(Uint8List arr) {
//   return BinaryBlob.fromList(arr);
// }

// BinaryBlob blobFromText(String text) {
//   return BinaryBlob.fromList(text.plainToU8a(useDartEncode: true));
// }

// BinaryBlob blobFromUint32Array(Uint32List arr) {
//   return BinaryBlob.fromList(arr.buffer.asUint8List());
// }

// DerEncodedBlob derBlobFromBlob(BinaryBlob blob) {
//   return DerEncodedBlob.fromList(blob);
// }

// BinaryBlob blobFromHex(String hex) {
//   return BinaryBlob.fromList(hex.toU8a());
// }

// String blobToHex(BinaryBlob blob) {
//   return blob.toHex();
// }

// Uint8List blobToUint8Array(BinaryBlob blob) {
//   return Uint8List.fromList(blob.sublist(0, blob.byteLength));
// }
