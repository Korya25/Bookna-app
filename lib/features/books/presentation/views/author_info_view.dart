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
      child: const _AuthorInfoContent(),
    );
  }
}

class _AuthorInfoContent extends StatelessWidget {
  const _AuthorInfoContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthorCubit, AuthorState>(
          listener: (context, state) {
            if (state is AuthorError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is AuthorLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AuthorLoaded) {
              final author = state.author;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthorHeaderWidget(author: author),
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
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
