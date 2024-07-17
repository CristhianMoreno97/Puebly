import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageViewerWidget extends StatelessWidget {
  final String image;

  const ImageViewerWidget(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    if (image == '') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/images/puebly-loader.gif',
          fit: BoxFit.cover,
        ),
      );
    }

    late ImageProvider imageProvider;
    if (image.startsWith('http') || (image.contains('http') && kIsWeb) ) {
      imageProvider = NetworkImage(image);
    } else {
      imageProvider = FileImage(File(image));
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: FadeInImage(
        image: imageProvider,
        fit: BoxFit.cover,
        placeholder: const AssetImage('assets/images/placeholder_2.png'),
      ),
    );
  }
}