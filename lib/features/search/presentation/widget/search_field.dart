import 'dart:async';

import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/search/presentation/controller/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _textController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    _textController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextFormField(
      controller: _textController,
      cursorColor: AppColors.primaryText,
      cursorWidth: AppSize.s1,
      style: textTheme.bodyLarge,
      onChanged: (title) {
        _debouncer.run(() {
          context.read<SearchCubit>().getBooksByTitle(title);
        });
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryText),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryText),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.primaryText,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear_rounded, color: AppColors.primaryText),
          onPressed: () {
            _textController.clear();
            context.read<SearchCubit>().getBooksByTitle('');
          },
        ),
        hintText: AppStrings.searchHint,
        hintStyle: textTheme.bodyLarge,
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? _callback;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback callback) {
    _callback = callback;
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), _execute);
  }

  void _execute() {
    _callback?.call();
  }

  void dispose() {
    _timer?.cancel();
  }
}
