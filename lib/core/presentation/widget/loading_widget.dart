import 'package:bookna_app/core/resources/app_values.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const CircularProgressIndicator(
        strokeWidth: AppSize.s4,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    );
  }
}
