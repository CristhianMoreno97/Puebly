import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:puebly/config/constants/enviroment_constants.dart';
import 'package:puebly/features/shared/infrasctructure/services/secure_storage_service.dart';

class SecureStorageServiceImpl extends SecureStorageService {
  FlutterSecureStorage get _secureStorage => const FlutterSecureStorage();
  AndroidOptions get _androidOptions => AndroidOptions(
        encryptedSharedPreferences: true,
        preferencesKeyPrefix: EnviromentConstants.preferencesKeyPrefix,
      );

  @override
  Future<void> deleteValueByKey(String key) async {
    return await _secureStorage.delete(
      key: key,
      aOptions: _androidOptions,
    );
  }

  @override
  Future<String?> getValueByKey(String key) async {
    return await _secureStorage.read(
      key: key,
      aOptions: _androidOptions,
    );
  }

  @override
  Future<void> setKeyValue(String key, String value) async {
    await _secureStorage.write(
      key: key,
      value: value,
      aOptions: _androidOptions,
    );
  }
}
