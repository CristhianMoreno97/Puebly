import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scaffoldKeyProvider =
    StateNotifierProvider<ScaffoldKeyNotifier, GlobalKey<ScaffoldState>>((ref) {
  return ScaffoldKeyNotifier();
});

class ScaffoldKeyNotifier extends StateNotifier<GlobalKey<ScaffoldState>> {
  ScaffoldKeyNotifier() : super(GlobalKey<ScaffoldState>());

  void drawerCloser(BuildContext context) {
    if (state.currentState!.isDrawerOpen) {
      Navigator.pop(context);
    }
  }

  void drawerOpener(BuildContext context) {
    if (!state.currentState!.isDrawerOpen) {
      state.currentState!.openDrawer();
    }
  }
}
