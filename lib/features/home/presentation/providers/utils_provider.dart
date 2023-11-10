import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final showHomeScreenProvider = StateProvider<bool>((ref) => true);
final showSectionsScreenProvider = StateProvider<bool>((ref) => true);

final scrollControllerProvider =
    StateProvider<ScrollController>((ref) => ScrollController());