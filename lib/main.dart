import 'package:bookna_app/core/resources/app_router.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_theme.dart';
import 'package:bookna_app/core/utils/setup_services_locator.dart';
import 'package:flutter/material.dart';

void main() {
  setupServicesLocator();
  runApp(const BooknaApp());
}

class BooknaApp extends StatelessWidget {
  const BooknaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      routerConfig: AppRouter.router,
    );
  }
}
