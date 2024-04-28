import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/analytics/services/analytics_service.dart';
import 'package:puebly/features/towns/presentation/providers/post_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchButton extends ConsumerWidget {
  const LaunchButton({
    super.key,
    required this.text,
    required this.icon,
    required this.uri,
    required this.actionTag,
    this.color = ColorManager.pueblyPrimary1,
  });

  final String text;
  final IconData icon;
  final Uri uri;
  final Color color;
  final String actionTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(postProvider).post;
    return SizedBox(
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () async {
          if (await canLaunchUrl(uri)) {
            switch (actionTag) {
              case 'whatsapp':
                AnalyticsService.selectedWhatsappButton(
                  post?.title ?? '',
                  post?.id ?? 0,
                );
                break;
              case 'call':
                AnalyticsService.selectedCallButton(
                    post?.title ?? '',
                    post?.id ?? 0,
                  );
                break;
              case 'location':
                AnalyticsService.selectedLocationButton(
                    post?.title ?? '',
                    post?.id ?? 0,
                  );
                break;
              default:
            }
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            throw 'Could not launch $uri';
          }
        },
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        label: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.white),
          ),
          backgroundColor: color,
          elevation: 0,
        ),
      ),
    );
  }
}
