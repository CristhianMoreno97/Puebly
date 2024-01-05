import 'package:flutter/material.dart';

class TownSectionsScreen extends StatelessWidget {
  final String townId;
  const TownSectionsScreen({super.key, required this.townId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(townId),
    );
  }
}
