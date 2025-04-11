import 'package:bookna_app/core/resources/app_router.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_theme.dart';
import 'package:bookna_app/features/favorite/presentation/controller/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooknaApp extends StatelessWidget {
  const BooknaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit(),
      child: MaterialApp.router(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
