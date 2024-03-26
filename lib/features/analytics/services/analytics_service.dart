import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:puebly/firebase_options.dart';

class AnalyticsService {
  static final _instance = FirebaseAnalytics.instance;

  static Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await _instance.setAnalyticsCollectionEnabled(true);
  }

  static getInstance() {
    return _instance;
  }

  static void selectedSection(String name) async {
    return _instance.logEvent(
      name: 'selected_section',
      parameters: {
        'page_name': name,
      },
    );
  }

  static void selectedPost(String name, int id) async {
    return _instance.logEvent(
      name: 'selected_post',
      parameters: {
        'post_name': name,
        'post_id': id,
      },
    );
  }

  static void selectedWhatsappButton(String postName, int postId) async {
    return _instance.logEvent(
      name: 'selected_whatsapp_button',
      parameters: {
        'post_name': postName,
        'post_id': postId,
      },
    );
  }

  static void selectedCallButton(String postName, int postId) async {
    return _instance.logEvent(
      name: 'selected_call_button',
      parameters: {
        'post_name': postName,
        'post_id': postId,
      },
    );
  }

  static void selectedLocationButton(String postName, int postId) async {
    return _instance.logEvent(
      name: 'selected_location_button',
      parameters: {
        'post_name': postName,
        'post_id': postId,
      },
    );
  }
}
