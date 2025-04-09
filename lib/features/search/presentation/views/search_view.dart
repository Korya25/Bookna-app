import 'package:bookna_app/core/presentation/widget/loading_widget.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/search/presentation/widget/search_field.dart';
import 'package:bookna_app/features/search/presentation/widget/search_text.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchWidget();
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: AppPadding.p12,
            left: AppPadding.p16,
            right: AppPadding.p16,
          ),
          child: Column(
            children: [
              SearchField(),
              SearchText(),
              //Expanded(child: LoadingWidget()),
              //  SearchGridView(results: state.searchResults),
              //    Expanded(child: ErrorText())
              //  NoResults()
            ],
          ),
        ),
      ),
    );
  }
}
