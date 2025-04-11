import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorPage({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: AppIconSize.s80,
              ),
              const SizedBox(height: AppSize.s20),
              Text('${AppStrings.oops}!'),
              const SizedBox(height: AppSize.s10),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: AppSize.s30),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p20,
                  vertical: AppPadding.p10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),

                  color: AppColors.error,
                ),
                child: GestureDetector(
                  onTap: onRetry,
                  child: Text(AppStrings.tryAgain),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
