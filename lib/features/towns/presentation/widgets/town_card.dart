import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/domain/entities/town.dart';

class TownCard extends StatelessWidget {
  final Town town;
  const TownCard({super.key, required this.town});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!town.enabled) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Próximamente en tu municipio'),
              backgroundColor: ColorManager.pueblySecundary1,
            ),
          );
          return;
        }
        context.push('/town/${town.id}');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 8,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ImageViewer(imagePath: town.featuredImgUrl),
            _HeaderText(text: town.name),
            _Content(text: town.description),
          ],
        ),
      ),
    );
  }
}

class _ImageViewer extends StatelessWidget {
  final String imagePath;

  const _ImageViewer({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth;
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          child: FadeInImage(
              width: width,
              height: width,
              fit: BoxFit.cover,
              image: NetworkImage(imagePath),
              placeholder: const AssetImage('assets/images/placeholder_2.jpg')),
        );
      },
    );
  }
}

class _HeaderText extends StatelessWidget {
  final String text;

  const _HeaderText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: ColorManager.pueblyPrimary2a,
            ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final String text;

  const _Content({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 16),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: ColorManager.pueblyPrimary2a,
            ),
      ),
    );
  }
}
