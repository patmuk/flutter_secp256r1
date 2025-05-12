import 'dart:convert';
import 'dart:typed_data';

import 'package:secp256r1/definitions/p256.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:secp256r1/secp256r1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _publicKey = 'Unknown';
  String _signed = 'Unknown';
  bool? _verified;
  String? _sharedSecret;

  final _payloadTEC = TextEditingController(text: 'Hello world');
  final _othersPublicKeyTEC = TextEditingController();

  String get alias => 'test_alias';

  String get _verifyPayload => _payloadTEC.text;

  @override
  void dispose() {
    _payloadTEC.dispose();
    _othersPublicKeyTEC.dispose();
    super.dispose();
  }

  Future<void> _getPublicKey() async {
    try {
      final r = await SecureP256.getPublicKey(alias);
      setState(() => _publicKey = hex.encode(r.rawKey));
    } catch (e) {
      setState(() => _publicKey = 'Error getting public key: $e');
    }
  }

  Future<void> _sign() async {
    try {
      final r = await SecureP256.sign(
        alias,
        Uint8List.fromList(utf8.encode(_verifyPayload)),
      );
      setState(() => _signed = hex.encode(r));
    } catch (e) {
      setState(() => _signed = 'Error signing: $e');
    }
  }

  Future<void> _verify() async {
    if (_publicKey == 'Unknown' || _signed == 'Unknown') {
      setState(() => _verified = null); // Reset if inputs are not ready
      return;
    }
    try {
      final r = await SecureP256.verify(
        Uint8List.fromList(utf8.encode(_verifyPayload)),
        P256PublicKey.fromRaw(
          Uint8List.fromList(hex.decode(_publicKey)),
        ),
        Uint8List.fromList(hex.decode(_signed)),
      );
      setState(() => _verified = r);
    } catch (e) {
      setState(() => _verified = false); // Indicate failure during verification
      print('Error verifying: $e'); // Log the error for debugging
    }
  }

  Future<void> _getSharedSecret(String publicKeyHex) async {
    if (publicKeyHex.isNotEmpty) {
      try {
        final r = await SecureP256.getSharedSecret(
          alias,
          P256PublicKey.fromRaw(
            Uint8List.fromList(
              hex.decode(publicKeyHex),
            ),
          ),
        );
        setState(() => _sharedSecret = hex.encode(r));
      } catch (e) {
        setState(() =>
            _sharedSecret = 'Error: Invalid Public Key or computation failed');
        print('Error getting shared secret: $e'); // Log the error for debugging
      }
    } else {
      setState(() {
        _sharedSecret = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            ElevatedButton(
              onPressed: _getPublicKey,
              child: const Text('Generate Public Key'),
            ),
            SelectableText('Public Key: $_publicKey\n'),
            TextFormField(
              // Changed to TextFormField for onChanged
              controller: _othersPublicKeyTEC,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Others Public Key (hex)',
              ),
              onChanged: (value) {
                // Use onChanged to trigger the shared secret calculation
                _getSharedSecret(value);
              },
            ),
            SelectableText('Shared Secret: ${_sharedSecret ?? 'Unknown'}\n'),
            TextField(
              controller: _payloadTEC,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Payload text field',
              ),
            ),
            ElevatedButton(
              onPressed: _sign,
              child: const Text('Sign Payload'),
            ),
            SelectableText('Signed Payload: $_signed\n'),
            ElevatedButton(
              onPressed: _verify,
              child: const Text('Verify Signature'),
            ),
            SelectableText(
                'Verification Status: ${_verified == null ? 'Unknown' : (_verified! ? 'Verified' : 'Not Verified')}\n'),
          ],
        ),
      ),
    );
  }
}
