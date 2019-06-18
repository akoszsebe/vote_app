import 'dart:convert';
import 'dart:typed_data';
import "package:pointycastle/export.dart";

class AesHelper {
  static Uint8List encrypt(String data, String token, String cipherIV) {
    var key = utf8.encode(token);
    var iv = utf8.encode(cipherIV);
    CipherParameters params = new PaddedBlockCipherParameters(
        new ParametersWithIV(new KeyParameter(key), iv), null);

    PaddedBlockCipherImpl cipherImpl = new PaddedBlockCipherImpl(
        new PKCS7Padding(), new CBCBlockCipher(new AESFastEngine()));
    cipherImpl.init(true, params);
    return cipherImpl.process(utf8.encode(data));
  }

  static String decrypt(Uint8List data, String token, String cipherIV) {
    Uint8List key = utf8.encode(token);
    Uint8List iv = utf8.encode(cipherIV);
    CipherParameters params = new PaddedBlockCipherParameters(
        new ParametersWithIV(new KeyParameter(key), iv), null);

    PaddedBlockCipherImpl cipherImpl = new PaddedBlockCipherImpl(
        new PKCS7Padding(), new CBCBlockCipher(new AESFastEngine()));
    cipherImpl.init(false, params);

    return utf8.decode(cipherImpl.process(data));
  }

  static String decryptBase64(
      String dataBase64, String tokenBase64, String cipherIVBase64) {
    Uint8List key = base64Decode(tokenBase64);
    print("key - " + key.length.toString());
    Uint8List iv = base64Decode(cipherIVBase64);
    print("iv - " + iv.length.toString());
    Uint8List encoded = base64Decode(dataBase64);
    print("encoded - " + encoded.length.toString());
    CipherParameters params = new PaddedBlockCipherParameters(
        new ParametersWithIV(new KeyParameter(key), iv), null);

    PaddedBlockCipherImpl cipherImpl = new PaddedBlockCipherImpl(
        new PKCS7Padding(), new CBCBlockCipher(new AESFastEngine()));
    cipherImpl.init(false, params);

    return utf8.decode(cipherImpl.process(encoded));
  }
}

Uint8List createUint8ListFromString(String s) {
  var ret = new Uint8List(s.length);
  for (var i = 0; i < s.length; i++) {
    ret[i] = s.codeUnitAt(i);
  }
  return ret;
}
