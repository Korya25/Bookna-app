import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:flutter/material.dart';

class AuthorReadingStatsWidget extends StatelessWidget {
  final Map<String, dynamic> author;

  const AuthorReadingStatsWidget({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.readingStats,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildStatCard(
              AppStrings.wantToRead,
              author['want_to_read_count'].toString(),
              Icons.bookmark,
            ),
            _buildStatCard(
              AppStrings.currentlyReading,
              author['currently_reading_count'].toString(),
              Icons.menu_book,
            ),
            _buildStatCard(
              AppStrings.alreadyRead,
              author['already_read_count'].toString(),
              Icons.check_circle,
            ),
            _buildStatCard(
              AppStrings.totalLogs,
              author['readinglog_count'].toString(),
              Icons.library_books,
            ),
          ],
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
            Text(
              title,
              style: TextStyle(fontSize: 14, color: AppColors.secondaryText),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
