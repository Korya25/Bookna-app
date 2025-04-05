import 'package:bookna_app/core/resources/app_colors.dart';
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 80),
              const SizedBox(height: 20),
              Text('Ooopps!'),
              const SizedBox(height: 10),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),

                  color: AppColors.error,
                ),
                child: GestureDetector(
                  onTap: onRetry,

                  child: const Text("try Again"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
