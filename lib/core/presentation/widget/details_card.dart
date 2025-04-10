// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:bookna_app/core/presentation/widget/slider_card_image.dart';
import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:bookna_app/features/favorite/presentation/controller/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    required this.detailsWidget,
    super.key,
    required this.book,
  });

  final Widget detailsWidget;
  final Book book;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Stack(
        children: [
          SliderCardImage(imageUrl: book.thumbnail),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: SizedBox(
              height: size.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: size.width * 0.7,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (book.title != null)
                                  Text(
                                    book.title as String,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.titleMedium,
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: AppPadding.p4,
                                    bottom: AppPadding.p6,
                                  ),
                                  child: detailsWidget,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            spacing: 3,
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                color: AppColors.ratingIconColor,
                                size: AppSize.s18,
                              ),
                              Text(
                                book.averageRating.toString(),
                                style: textTheme.bodyMedium,
                              ),
                              Text(
                                '(${book.ratingsCount.toString()})',
                                style: textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (book.previewLink != null)
                      Padding(
                        padding: const EdgeInsets.only(left: AppPadding.p8),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () async {
                              final url = Uri.parse(book.previewLink ?? '');
                              if (book.previewLink != null &&
                                  await canLaunchUrl(url)) {
                                await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'There is no preview link for this book.',
                                    ),
                                  ),
                                );
                              }
                            },
                            borderRadius: BorderRadius.circular(25),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: AppSize.s45,
                              width: AppSize.s45,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.chrome_reader_mode,
                                color: AppColors.secondaryText,
                                size: AppSize.s30,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: AppPadding.p12,
              left: AppPadding.p16,
              right: AppPadding.p16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.iconContainerColor,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.secondaryText,
                      size: AppSize.s20,
                    ),
                  ),
                ),
                BlocBuilder<FavoriteCubit, List<Book>>(
                  builder: (context, favoriteBooks) {
                    final isFavorite = context.read<FavoriteCubit>().isFavorite(
                      book,
                    );

                    return InkWell(
                      onTap: () {
                        if (isFavorite) {
                          context.read<FavoriteCubit>().removeFromFavorites(
                            book,
                          );
                        } else {
                          context.read<FavoriteCubit>().addToFavorites(book);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.iconContainerColor,
                        ),
                        child: Icon(
                          Icons.bookmark_rounded,
                          color: isFavorite ? Colors.red : null,
                          size: AppSize.s20,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
