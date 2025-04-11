// ignore_for_file: deprecated_member_use

import 'package:bookna_app/core/resources/app_values.dart';
import 'package:flutter/material.dart';

class NiceLoadingWidget extends StatefulWidget {
  const NiceLoadingWidget({super.key});

  @override
  State<NiceLoadingWidget> createState() => _NiceLoadingWidgetState();
}

class _NiceLoadingWidgetState extends State<NiceLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    _opacity = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _opacity,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16,
            vertical: AppPadding.p8,
          ),
          decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.book_rounded,
                color: Colors.white,
                size: AppIconSize.s20,
              ),
              const SizedBox(width: AppSize.s8),
              Text(
                'Unpacking new stories...',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
