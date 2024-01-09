import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/towns/domain/entities/post.dart';
import 'package:puebly/features/towns/presentation/providers/post_provider.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_appbar.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_drawer.dart';

class PostScreen extends ConsumerWidget {
  final String postId;
  const PostScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(postProvider);

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body:
          post != null ? _PostView(post) : const Text('\n¡Post no encontrado!'),
    );
  }
}

class _PostView extends StatelessWidget {
  final Post post;
  const _PostView(this.post);

  List<String> dividirCadena(String cadena) {
    List<String> lineas = cadena.trim().split('\n\n\n\n');

    for (var i = 0; i < lineas.length; i++) {
      lineas[i] = lineas[i].trim();

      if (!(i + 1 < lineas.length)) {
        break;
      }

      if (lineas[i].isNotEmpty) {
        if (lineas[i + 1].isNotEmpty) {
          lineas[i] += '\n${lineas[i + 1]}';
          lineas.removeAt(i + 1);
          i--;
        }
        continue;
      }

      if (lineas[i + 1].isNotEmpty) {
        lineas[i - 1] += '';
        lineas.removeAt(i);
        i--;
      }
    }
    return lineas;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> postContent = dividirCadena(post.content);
    final maxLength = postContent.length > post.images.length
        ? postContent.length
        : post.images.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.title),
          _ImageViewer(post.featuredImgUrl),
          for (var i = 0; i < maxLength; i++) ...[
            if (i < postContent.length && postContent[i].isNotEmpty)
              _TextContent(postContent[i]),
            if (i < post.images.length) _ImageViewer(post.images[i]),
          ],
        ],
      ),
    );
  }
}

class _TextContent extends StatelessWidget {
  final String text;
  const _TextContent(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _ImageViewer extends StatelessWidget {
  final String imagePath;
  const _ImageViewer(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: CachedNetworkImage(
          imageUrl: imagePath,
          width: double.infinity,
          height: 220,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: Image.asset(
              'assets/images/ph_2.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 220,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
