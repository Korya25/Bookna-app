import 'package:bookna_app/core/presentation/widget/image_with_shimmer.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:flutter/material.dart';

class GridViewCard extends StatelessWidget {
  const GridViewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s8),
              child: ImageWithShimmer(
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTl4yDlizyuarmLLKeymm_53zt4RY9CV03HHQ&s',
                width: double.infinity,
                height: AppSize.s150,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            'The Alchemist',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
