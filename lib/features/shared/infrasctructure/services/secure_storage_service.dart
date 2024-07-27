abstract class SecureStorageService {
  Future<void> setKeyValue(String key, String value);
  Future<String?> getValueByKey(String key);
  Future<void> deleteValueByKey(String key);
}
