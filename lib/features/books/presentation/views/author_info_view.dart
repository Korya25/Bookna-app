import 'package:another_flushbar/flushbar.dart';
import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/utils/setup_services_locator.dart';
import 'package:bookna_app/features/books/presentation/controller/author_cubit/author_cubit.dart';
import 'package:bookna_app/features/books/presentation/widget/author_additional_info_widget.dart';
import 'package:bookna_app/features/books/presentation/widget/author_header_widget.dart';
import 'package:bookna_app/features/books/presentation/widget/author_rating_widget.dart';
import 'package:bookna_app/features/books/presentation/widget/author_reading_stats_widget.dart.dart';
import 'package:bookna_app/features/books/presentation/widget/author_subjects_widget.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorInfoView extends StatelessWidget {
  const AuthorInfoView({super.key, required this.authorName});

  final String authorName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthorCubit>()..fetchAuthorData(authorName),
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<AuthorCubit, AuthorState>(
            listener: (context, state) {
              if (state is AuthorLoaded) {
                _showTopFlushbar(
                  context,
                  "This information may not be accurate enough and confusion between individuals may occur.",
                );
              } else if (state is AuthorError) {
                _showTopFlushbar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is AuthorLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AuthorLoaded) {
                final author = state.author;
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthorHeaderWidget(
                        author: author,
                        authorName: authorName, // Add this back
                      ),
                      const SizedBox(height: 24),
                      AuthorRatingWidget(author: author),
                      const SizedBox(height: 24),
                      AuthorReadingStatsWidget(author: author),
                      const SizedBox(height: 24),
                      AuthorSubjectsWidget(author: author),
                      const SizedBox(height: 24),
                      AuthorAdditionalInfoWidget(author: author),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink(); // Error handled in listener
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showTopFlushbar(BuildContext context, String message) async {
    Flushbar(
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 4),
      backgroundColor: AppColors.secondaryBackground,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(10),
      icon: const Icon(Icons.info, color: Colors.white),
    ).show(context);
  }
}
