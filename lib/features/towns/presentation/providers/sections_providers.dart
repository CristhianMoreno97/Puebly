import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sectionsPageControllerProvider =
    StateProvider<PageController>((ref) => PageController());

final selectedSectionIndexProvider =
    StateProvider<int>((ref) => 0);

final sectionsScrollControllerProvider =
    StateProvider<ScrollController>((ref) => ScrollController());

final showTownSectionsViewProvider =
    StateProvider<bool>((ref) => true);