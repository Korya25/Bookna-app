import 'package:bookna_app/core/resources/app_router.dart';
import 'package:bookna_app/core/resources/app_routes.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.child});

  final Widget child;
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  // index of the selected item
  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(booksPath)) {
      return 0;
    }
    
    if (location.startsWith(searchPath)) {
      return 1;
    }
    if (location.startsWith(favoritePath)) {
      return 2;
    }
    return 0;
  }

  // selected item index in the bottom navigation bar
  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.booksRoute);
      
        break;
      case 1:
        context.goNamed(AppRoutes.searchRoute);
        break;
      case 2:
        context.goNamed(AppRoutes.favoriteRoute);
        break;
    }
  }

  // list of items in the bottom navigation bar
  final List<NavItemModel> navItemList = [
    NavItemModel(label: AppStrings.books, icon: Icons.book),
  
    NavItemModel(label: AppStrings.search, icon: Icons.search_rounded),
    NavItemModel(label: AppStrings.favorite, icon: Icons.favorite_rounded),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,

      bottomNavigationBar: BottomNavigationBar(
        items: [
          for (var item in navItemList)
            BottomNavigationBarItem(label: item.label, icon: Icon(item.icon)),
        ],
        currentIndex: _getSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }
}

// model for bottom navigation bar items

class NavItemModel {
  final String label;
  final IconData icon;
  NavItemModel({required this.label, required this.icon});
}
