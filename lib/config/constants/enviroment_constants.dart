import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnviromentConstants {
  static initEnviroment() async {
    await dotenv.load(fileName: ".env");
  }

  static String get homeURL => dotenv.env['URL_BASE'] ?? '';

  static String get whatsappNumber => dotenv.env['PUEBLY_WHATSAPP_NUMBER'] ?? '';

  static String get preferencesKeyPrefix => dotenv.env['PREFERENCES_KEY_PREFIX'] ?? '';

  static String get sharedSecretKey => dotenv.env['SHARED_SECRET_KEY'] ?? '';

  static String get postTrackingHost => dotenv.env['POST_TRACKING_HOST'] ?? '';
}