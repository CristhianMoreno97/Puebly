import 'package:dio/dio.dart';
import 'package:puebly/config/constants/enviroment_constants.dart';
import 'package:puebly/features/users/utils/hmac.dart';
import 'package:puebly/features/users/utils/uuid.dart';

class PostTrackingService {
  late final Dio _dio;

  PostTrackingService() {
    _dio = Dio();
    _dio.options.baseUrl = EnviromentConstants.postTrackingHost;
    _dio.options.headers = {'Content-Type': 'application/json'};
  }

  Future<void> logPostView(int id, String? title) async {
    final deviceUuid = await getDeviceUuid();
    final hmac = generateHmac(deviceUuid, EnviromentConstants.sharedSecretKey);

    var data = {
      'uuid': deviceUuid,
      'hmac': hmac,
      'post_id': id,
    };

    if (title != null) {
      data['post_title'] = title;
    }

    try {
      await _dio.post('/api/v1/log-post-visit', data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logPostInteraction(int postId, String type) async {
    final deviceUuid = await getDeviceUuid();
    final hmac = generateHmac(deviceUuid, EnviromentConstants.sharedSecretKey);

    var data = {
      'uuid': deviceUuid,
      'hmac': hmac,
      'post_id': postId,
      'type': type, // nombre sugerido: action_tag
    };

    try {
      await _dio.post('/api/v1/log-post-interaction', data: data);
    } catch (e) {
      rethrow;
    }
  }
}
