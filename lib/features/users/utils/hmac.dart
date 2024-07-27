import 'dart:convert';

import 'package:crypto/crypto.dart';

String generateHmac(String uuid, String secretKey) {
  var key = utf8.encode(secretKey);
  var bytes = utf8.encode(uuid);

  var hmacSha256 = Hmac(sha256, key); // Crear el HMAC-SHA256
  var digest = hmacSha256.convert(bytes);

  return digest.toString();
}
