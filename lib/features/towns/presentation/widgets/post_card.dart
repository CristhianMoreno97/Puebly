import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/domain/entities/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.0),
            spreadRadius: 4,
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
        border: Border.all(
          color: ColorManager.pueblyPrimary1.withOpacity(0.2),
          width: 2,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ImageViewer(post.featuredImgUrl),
          Expanded(child: _TextContent(post.title)),
        ],
      ),
    );
  }
}

class _ImageViewer extends StatelessWidget {
  final String imagePath;
  const _ImageViewer(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
      child: FadeInImage(
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        image: NetworkImage(imagePath),
        placeholder: const AssetImage('assets/images/placeholder_2.jpg'),
      ),
    );
  }
}

class _TextContent extends StatelessWidget {
  final String text;
  const _TextContent(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}
