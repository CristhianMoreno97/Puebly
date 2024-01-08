import 'package:flutter_riverpod/flutter_riverpod.dart';

final webViewPathProvider = StateProvider<String>((ref) => '');

final webViewIsLoadingProvider = StateProvider<bool>((ref) => false);