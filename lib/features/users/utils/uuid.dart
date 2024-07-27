import 'package:puebly/features/shared/infrasctructure/services/secure_storage_service_impl.dart';
import 'package:uuid/uuid.dart';

Future<String> getDeviceUuid() async {
  String? uuid = await SecureStorageServiceImpl().getValueByKey('device_uuid');

  if (uuid == null) {
    uuid = generateUuid();
    await SecureStorageServiceImpl().setKeyValue('device_uuid', uuid);
  }
  return uuid;
}

String generateUuid() {
  return const Uuid().v4();
}
