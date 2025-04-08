// ignore_for_file: deprecated_member_use

import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/books/domain/entities/author.dart';
import 'package:flutter/material.dart';

class AuthorAdditionalInfoWidget extends StatelessWidget {
  final Author author;
  final bool showAllInfo;

  const AuthorAdditionalInfoWidget({
    super.key,
    required this.author,
    this.showAllInfo = false,
  });

  @override
  Widget build(BuildContext context) {
    final infoItems = _buildInfoItems(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.additionalInformation,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              if (infoItems.isNotEmpty)
                ...infoItems.expand(
                  (item) => [item, if (item != infoItems.last) _buildDivider()],
                )
              else
                _buildEmptyState(),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildInfoItems(BuildContext context) {
    final items = <Widget>[];

    items.add(
      _buildInfoCard(
        context: context,
        icon: Icons.person,
        title: AppStrings.authorType,
        value: author.type ?? AppStrings.unknown,
      ),
    );

    if (author.birthDate != null || showAllInfo) {
      items.add(
        _buildInfoCard(
          context: context,
          icon: Icons.cake,
          title: AppStrings.birthDate,
          value: author.birthDate ?? AppStrings.notAvailable,
        ),
      );
    }

    if (author.deathDate != null || showAllInfo) {
      items.add(
        _buildInfoCard(
          context: context,
          icon: Icons.event,
          title: AppStrings.deathDate,
          value: author.deathDate ?? AppStrings.notAvailable,
        ),
      );
    }

    return items;
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 25),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.grey.withOpacity(0.2), indent: 48);
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Text(
          AppStrings.noAdditionalInfoAvailable,
          style: TextStyle(
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
