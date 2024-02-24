import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchButton extends StatelessWidget {
  const LaunchButton({
    super.key,
    required this.text,
    required this.icon,
    required this.uri,
    this.color = ColorManager.pueblyPrimary1,
  });

  final String text;
  final IconData icon;
  final Uri uri;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () async {
          if (await canLaunchUrl(uri)) {
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
