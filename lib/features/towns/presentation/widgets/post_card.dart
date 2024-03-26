import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/analytics/services/analytics_service.dart';
import 'package:puebly/features/towns/domain/entities/post.dart';
import 'package:puebly/features/towns/presentation/providers/post_provider.dart';

class PostCard extends ConsumerWidget {
  final Post? post;
  const PostCard({super.key, this.post});

  List<String> _getPostCategoryNames(List<Map<String, dynamic>>? categories) {
    if (categories == null) {
      return [];
    }

    return categories
        .map<String>((category) => category['name'] ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (post == null) return;
        AnalyticsService.selectedPost(post?.title ?? '', post?.id ?? 0);
        ref.read(postProvider.notifier).state = post;
        context.push('/post/${post!.id}');
      },
      child: Container(
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
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImageViewer(post?.featuredImgUrl),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TextContent(post?.title),
                    const SizedBox(height: 4),
                    _PostCategories(
                      categories: _getPostCategoryNames(post?.categories),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostCategories extends StatefulWidget {
  const _PostCategories({required this.categories});

  final List<String> categories;

  @override
  State<_PostCategories> createState() => _PostCategoriesState();
}

class _PostCategoriesState extends State<_PostCategories> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.categories.length > 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          //_scrollController.jumpTo(0);
          _scrollController.animateTo(0,
              duration: const Duration(seconds: 2), curve: Curves.ease);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.categories.isEmpty
        ? const SizedBox()
        : SizedBox(
            height: 32,
            child: MasonryGridView.count(
              scrollDirection: Axis.horizontal,
              crossAxisCount: 1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              controller: _scrollController,
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                final category = widget.categories[index];
                return _Badget(text: category);
              },
            ),
          );
  }
}

class _Badget extends StatelessWidget {
  const _Badget({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: const BoxDecoration(
        color: ColorManager.brightYellowTint1,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: ColorManager.brightYellowShade2,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

class _ImageViewer extends StatelessWidget {
  final String? imagePath;
  const _ImageViewer(this.imagePath);

  @override
  Widget build(BuildContext context) {
    if (imagePath == null) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
        child: Image.asset(
          'assets/images/puebly-loader.gif',
          fit: BoxFit.cover,
          width: 120,
          height: 120,
        ),
      );
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
      child: CachedNetworkImage(
        imageUrl: imagePath ?? '',
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: ClipRRect(
            child: Image.asset('assets/images/puebly-loader.gif',
                fit: BoxFit.cover, width: 120, height: 120),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

class _TextContent extends StatelessWidget {
  final String? text;
  const _TextContent(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: Theme.of(context).textTheme.titleSmall,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
