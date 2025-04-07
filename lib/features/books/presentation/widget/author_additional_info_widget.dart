import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:flutter/material.dart';

class AuthorAdditionalInfoWidget extends StatelessWidget {
  final Map<String, dynamic> author;

  const AuthorAdditionalInfoWidget({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // العنوان
        Text(
          AppStrings.additionalInformation,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),

        // حاوية البطاقات
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildInfoCard(
                icon: Icons.person,
                title: 'Type',
                value: author['type'],
              ),

              if (author['birth_date'] != null) ...[
                _buildDivider(),
                _buildInfoCard(
                  icon: Icons.cake,
                  title: 'Birth Date',
                  value: author['birth_date'],
                ),
              ],
              if (author['death_date'] != null) ...[
                _buildDivider(),
                _buildInfoCard(
                  icon: Icons.event,
                  title: 'Death Date',
                  value: author['death_date'],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // Widget لبناء بطاقة معلومات واحدة
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // الأيقونة
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue[700], size: 24),
          ),
          const SizedBox(width: 12),
          // النص
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(fontSize: 14, color: AppColors.primaryText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
      indent: 12,
      endIndent: 12,
    );
  }
}
