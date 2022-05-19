import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorages {
  final storage = new FlutterSecureStorage();

  Future setStorage(String key, value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> readStorage(keys) async {
    var read = await storage.read(key: keys);

    return read;
  }

  Future deleteKey(String key) async {
    await storage.delete(key: key);
  }
}
