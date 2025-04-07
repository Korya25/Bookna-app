import 'package:another_flushbar/flushbar.dart';
import 'package:bookna_app/core/data/network/api_constants.dart';
import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/utils/functions/route_function.dart';
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
          "ratings_average": 0,
          "ratings_sortable": 2.047372,
          "ratings_count": 0,
          "ratings_count_1": 0,
          "ratings_count_2": 0,
          "ratings_count_3": 0,
          "ratings_count_4": 0,
          "ratings_count_5": 0,
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

    // استدعاء Flushbar بعد تحميل البيانات
    if (!isLoading) {
      showTopFlushbar(
        context,
        "This information may not be accurate enough and confusion between individuals may occur.",
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
                      _buildAuthorHeader(),
                      const SizedBox(height: 24),
                      _buildRatingSection(),
                      const SizedBox(height: 24),
                      _buildReadingStatsSection(),
                      const SizedBox(height: 24),
                      _buildSubjectsSection(),
                      const SizedBox(height: 24),
                      _buildAdditionalInfoSection(),
                    ],
                  ),
                ),
      ),
    );
  }

  Widget _buildAuthorHeader() {
    final author = authorData!['docs'][0];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          ApiConstants.authorPlaceholder,
          width: 100,
          height: 150,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const SizedBox(
              width: 100,
              height: 150,
              child: Center(child: CircularProgressIndicator()),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox(
              width: 100,
              height: 150,
              child: Icon(Icons.error),
            );
          },
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.authorName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Top Work: ${author['top_work']}',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              Text(
                'Works: ${author['work_count']}',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              if (author['alternate_names'] != null &&
                  author['alternate_names'].isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Also known as:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    ...author['alternate_names'].map<Widget>(
                      (name) => Text(
                        '• $name',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    final author = authorData!['docs'][0];
    final rating = author['ratings_average'] as num;
    final ratingCount = author['ratings_count'];
    final ratingDistribution = [
      author['ratings_count_1'],
      author['ratings_count_2'],
      author['ratings_count_3'],
      author['ratings_count_4'],
      author['ratings_count_5'],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ratings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StarRating(rating: rating.toDouble()),
                Text(
                  'Based on $ratingCount ratings',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...List.generate(5, (index) {
          final stars = 5 - index;
          final count = ratingDistribution[stars - 1];
          final percentage =
              ratingCount > 0 ? (count / ratingCount) * 100 : 0.0;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Text('$stars stars'),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getRatingColor(stars),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text('${percentage.toStringAsFixed(1)}%'),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildReadingStatsSection() {
    final author = authorData!['docs'][0];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reading Stats',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildStatCard(
              'Want to Read',
              author['want_to_read_count'].toString(),
              Icons.bookmark,
            ),
            _buildStatCard(
              'Currently Reading',
              author['currently_reading_count'].toString(),
              Icons.menu_book,
            ),
            _buildStatCard(
              'Already Read',
              author['already_read_count'].toString(),
              Icons.check_circle,
            ),
            _buildStatCard(
              'Total Logs',
              author['readinglog_count'].toString(),
              Icons.library_books,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubjectsSection() {
    final author = authorData!['docs'][0];
    final subjects = author['top_subjects'] as List<dynamic>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Top Subjects',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              subjects
                  .map(
                    (subject) => Chip(
                      label: Text(subject),
                      backgroundColor: Colors.blue[50],
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoSection() {
    final author = authorData!['docs'][0];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Type'),
          subtitle: Text(author['type']),
        ),
        ListTile(
          leading: const Icon(Icons.vpn_key),
          title: const Text('Key'),
          subtitle: Text(author['key']),
        ),
        if (author['birth_date'] != null)
          ListTile(
            leading: const Icon(Icons.cake),
            title: const Text('Birth Date'),
            subtitle: Text(author['birth_date']),
          ),
        if (author['death_date'] != null)
          ListTile(
            leading: const Icon(Icons.event),
            title: const Text('Death Date'),
            subtitle: Text(author['death_date']),
          ),
        ListTile(
          leading: const Icon(Icons.sort),
          title: const Text('Ratings Sortable'),
          subtitle: Text(author['ratings_sortable'].toString()),
        ),
        ListTile(
          leading: const Icon(Icons.code),
          title: const Text('Version'),
          subtitle: Text(author['_version_'].toString()),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      color: AppColors.secondaryBackground,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 30, color: Colors.blue),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRatingColor(int stars) {
    switch (stars) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow[700]!;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

class StarRating extends StatelessWidget {
  final double rating;

  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(Icons.star, color: Colors.amber, size: 20);
        } else if (index < rating.ceil()) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 20);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 20);
        }
      }),
    );
  }
}
