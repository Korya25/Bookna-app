import 'package:another_flushbar/flushbar.dart';
import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/books/presentation/widget/author_additional_info_widget.dart';
import 'package:bookna_app/features/books/presentation/widget/author_header_widget.dart';
import 'package:bookna_app/features/books/presentation/widget/author_rating_widget.dart';
import 'package:bookna_app/features/books/presentation/widget/author_reading_stats_widget.dart.dart';
import 'package:bookna_app/features/books/presentation/widget/author_subjects_widget.dart.dart';
import 'package:flutter/material.dart';

class AuthorInfoView extends StatefulWidget {
  const AuthorInfoView({super.key, required this.authorName});
  final String authorName;

  @override
  State<AuthorInfoView> createState() => _AuthorInfoViewState();
}

class _AuthorInfoViewState extends State<AuthorInfoView> {
  Map<String, dynamic>? authorData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAuthorData();
  }

  Future<void> fetchAuthorData() async {
    await Future.delayed(const Duration(seconds: 1));

    final mockData = {
      "numFound": 1,
      "start": 0,
      "numFoundExact": true,
      "docs": [
        {
          "alternate_names": [
            "Robert Greene (1886-) Lee",
            "Robert Greene 1886-1978 Lee",
          ],
          "birth_date": "1886",
          "death_date": "1978",
          "key": "OL588561A",
          "name": "Robert Greene Lee",
          "top_subjects": [
            "Sermons",
            "Baptists",
            "American Sermons",
            "Sermons, American",
            "20th century",
            "Homiletical illustrations",
            "Baptists, sermons",
            "Sermons, american",
            "Evangelistic sermons",
            "Miracles",
          ],
          "top_work": "Beds of Pearls",
          "type": "author",
          "work_count": 58,
          "ratings_average": 9,
          "ratings_sortable": 2.047372,
          "ratings_count": 10,
          "ratings_count_1": 5,
          "ratings_count_2": 6,
          "ratings_count_3": 7,
          "ratings_count_4": 8,
          "ratings_count_5": 9,
          "want_to_read_count": 3,
          "already_read_count": 1,
          "currently_reading_count": 0,
          "readinglog_count": 4,
          "_version_": "1826815502936178694",
        },
      ],
    };

    setState(() {
      authorData = mockData;
      isLoading = false;
    });

    if (!isLoading) {
      showTopFlushbar(
        // ignore: use_build_context_synchronously
        context,
       AppStrings.messageshowTopFlushbar,
      );
    }
  }

  Future<void> showTopFlushbar(BuildContext context, String message) async {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthorHeaderWidget(
                        author: authorData!['docs'][0],
                        authorName: widget.authorName,
                      ),
                      const SizedBox(height: 24),
                      AuthorRatingWidget(author: authorData!['docs'][0]),
                      const SizedBox(height: 24),
                      AuthorReadingStatsWidget(author: authorData!['docs'][0]),
                      const SizedBox(height: 24),
                      AuthorSubjectsWidget(author: authorData!['docs'][0]),
                      const SizedBox(height: 24),
                      AuthorAdditionalInfoWidget(
                        author: authorData!['docs'][0],
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
