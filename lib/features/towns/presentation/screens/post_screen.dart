import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/infraestructure/services/post_tracking_service.dart';
import 'package:puebly/features/towns/presentation/providers/post_provider.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_appbar.dart';
import 'package:puebly/features/towns/presentation/widgets/launch_button.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_drawer.dart';

class PostScreen extends ConsumerStatefulWidget {
  final String postId;
  const PostScreen({super.key, required this.postId});

  @override
  PostScreenState createState() => PostScreenState();
}

class PostScreenState extends ConsumerState<PostScreen> {
  @override
  void initState() {
    super.initState();
    final postId = int.tryParse(widget.postId);
    if (postId != null) {
      _postTrackingInit(ref, postId);
      Future.microtask(() => initDeepLinks(ref));
    }
  }

  // TODO warning: when opening a second link, initState does not run again

  @override
  void dispose() {
    super.dispose();
  }

  void _postTrackingInit(WidgetRef ref, int postId) {
    final postState = ref.read(postProvider);
    PostTrackingService().logPostView(postId, postState.post?.title);
  }

  Future<void> initDeepLinks(WidgetRef ref) async {
    final postId = int.tryParse(widget.postId);
    if (postId == null) return;

    final post = ref.read(postProvider).post;
    if (post == null || post.id != postId) {
      await ref.read(postProvider.notifier).getPost(postId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: _PostView(), // TODO implement loading state
    );
  }
}

class _PostView extends ConsumerWidget {
  const _PostView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postState = ref.watch(postProvider);

    return postState.isLoading
        ? const _LoadingProgress()
        : const _PostContent();
  }
}

class _PostContent extends ConsumerWidget {
  const _PostContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postState = ref.watch(postProvider);
    final post = postState.post;
    return SafeArea(
      child: post != null
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TitleText(post.title),
                      _FeaturedImage(post.featuredImgUrl,
                          galleryImageUrls: post.images),
                      _HtmlContent(post.content, galleryImageUrls: post.images),
                      const SizedBox(height: 16),
                      _ContactInfo(post.contactInfo),
                      const SizedBox(
                        height: 16,
                      ),
                      const _DisclaimerInfo(),
                    ],
                  ),
                ),
              ),
            )
          : const Text('Publicación no encontrada.'),
    );
  }
}

class _DisclaimerInfo extends StatelessWidget {
  const _DisclaimerInfo();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Puebly actúa únicamente como un intermediario que facilita la publicación de información por parte de terceros. Puebly no se responsabiliza por los negocios realizados entre el dueño de la publicación y el usuario final. Se recomienda verificar la autenticidad y las condiciones del servicio/producto ofrecido antes de realizar cualquier transacción.',
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.black54,
          ),
    );
  }
}

class _LoadingProgress extends ConsumerWidget {
  const _LoadingProgress();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const LinearProgressIndicator(
          color: ColorManager.colorSeed,
          backgroundColor: Colors.white,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/puebly-loader.gif',
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactInfo extends StatelessWidget {
  final Map<String, String> contactInfo;

  const _ContactInfo(this.contactInfo);

  @override
  Widget build(BuildContext context) {
    const defaultWhatsAppMessage = 'Hola, vi tu publicación en Puebly...\n';
    final whatsappNumber = '+57${contactInfo['whatsapp']}';

    // Lista de botones
    final List<Widget> items = [
      contactInfo['whatsapp'] != ''
          ? LaunchButton(
              text: 'WhatsApp',
              icon: FontAwesomeIcons.whatsapp,
              uri: Uri.parse(
                  'whatsapp://send?phone=$whatsappNumber&text=$defaultWhatsAppMessage'),
              actionTag: 'whatsapp',
            )
          : const SizedBox(),
      const SizedBox(width: 8, height: 8),
      contactInfo['phone'] != ''
          ? LaunchButton(
              text: 'Llamar',
              icon: Icons.phone,
              uri: Uri.parse('tel:${contactInfo['phone']}'),
              color: ColorManager.blueShade2,
              actionTag: 'call',
            )
          : const SizedBox(),
      const SizedBox(width: 8, height: 8),
      contactInfo['location'] != ''
          ? LaunchButton(
              text: 'Ubicación',
              icon: Icons.location_on,
              uri: Uri.parse(contactInfo['location'] ?? ''),
              color: ColorManager.colorSeed,
              actionTag: 'location',
            )
          : const SizedBox(),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 480) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: items
                .map((item) =>
                    item is LaunchButton ? Expanded(child: item) : item)
                .toList(),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...items,
            ],
          );
        }
      },
    );
  }
}

class _FeaturedImage extends StatelessWidget {
  final String imageUrl;
  final List<String> galleryImageUrls;
  const _FeaturedImage(this.imageUrl, {required this.galleryImageUrls});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                _FullScreenImageViewer(galleryImageUrls, index: 0),
          ));
        },
        child: _ImageViewer(imageUrl));
  }
}

class _HtmlContent extends StatefulWidget {
  final String htmlContent;
  final List<String> galleryImageUrls;
  const _HtmlContent(this.htmlContent, {required this.galleryImageUrls});

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
                  builder: (context) => _FullScreenImageViewer(
                      widget.galleryImageUrls,
                      index: currentIndex),
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
    final width = MediaQuery.of(context).size.width;
    final height = width > 800 ? 340.0 : 220.0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: CachedNetworkImage(
          imageUrl: imagePath,
          width: double.infinity,
          height: height,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: Image.asset(
              'assets/images/puebly-loader.gif',
              fit: BoxFit.cover,
              width: double.infinity,
              height: height,
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
