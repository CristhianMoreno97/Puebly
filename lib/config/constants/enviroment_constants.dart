import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnviromentConstants {
  static initEnviroment() async {
    await dotenv.load(fileName: ".env");
  }

  static String get webUrl => dotenv.env['URL_BASE'] ?? '';

  static String get whatsappNumber => dotenv.env['PUEBLY_WHATSAPP_NUMBER'] ?? '';
}