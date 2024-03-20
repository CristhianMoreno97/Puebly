import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/analytics/services/analytics_service.dart';
import 'package:puebly/features/towns/presentation/widgets/town_sections_info.dart';
import 'package:puebly/features/towns/utils/section_utils.dart';

class SectionCard extends ConsumerWidget {
  final SectionInfo section;
  final int index;

  const SectionCard(
    this.section, {
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        AnalyticsService.selectedSection(TownSectionsInfo.sections[index].name);
        await SectionUtils.navigateTo(index, ref, context);
        return;
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: section.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            _TextInfo(
              section.name,
              section.description,
              icon: section.selectedIcon,
            ),
            const SizedBox(width: 8),
            _FeaturedImage(section.featuredImage),
          ],
        ),
      ),
    );
  }
}

class _FeaturedImage extends StatelessWidget {
  final String imagePath;

  const _FeaturedImage(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(500),
      child: Image.asset(
        imagePath,
        width: 80,
        height: 80,
      ),
    );
  }
}

class _TextInfo extends StatelessWidget {
  final String header;
  final String description;
  final IconData icon;

  const _TextInfo(this.header, this.description, {required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _IconInfo(icon),
              const SizedBox(width: 16),
              Text(
                header,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _IconInfo extends StatelessWidget {
  final IconData icon;

  const _IconInfo(this.icon);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Colors.white,
      size: 24,
    );
  }
}
