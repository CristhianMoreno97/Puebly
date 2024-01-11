import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:puebly/config/theme/color_manager.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TitleText(post.title),
            _ImageViewer(post.featuredImgUrl),
            _HtmlContent(post.content, imagePaths: post.images),
          ],
        ),
      ),
    );
  }
}

class _HtmlContent extends StatefulWidget {
  final String htmlContent;
  final List<String> imagePaths;
  const _HtmlContent(this.htmlContent, {required this.imagePaths});

  @override
  State<_HtmlContent> createState() => _HtmlContentState();
}

class _HtmlContentState extends State<_HtmlContent> {
  var imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      widget.htmlContent,
      customStylesBuilder: (element) {
        if (element.localName == 'figure') {
          return {
            'margin': '0',
            'padding': '0',
            'width': '100%',
            'height': 'auto',
          };
        }
        return null;
      },
      customWidgetBuilder: (element) {
        if (element.localName == 'img') {
          final src = element.attributes['src'];
          imageIndex++;
          final currentIndex = imageIndex;
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      _FullScreenImageViewer(widget.imagePaths, index: currentIndex),
                ));
              },
              child: _ImageViewer(src!));
        }
        return null;
      },
    );
  }
}

class _TitleText extends StatelessWidget {
  final String text;
  const _TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: ColorManager.colorSeed),
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

class _FullScreenImageViewer extends StatelessWidget {
  final List<String> imagePaths;
  final int index;
  const _FullScreenImageViewer(this.imagePaths, {required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        itemCount: imagePaths.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(imagePaths[index]),
            initialScale: PhotoViewComputedScale.contained * 1,
            minScale: PhotoViewComputedScale.contained * 1,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        pageController: PageController(initialPage: index),
      ),
    );
  }
}
