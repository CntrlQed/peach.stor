import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import 'app_bottom_nav.dart';

class BasePage extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool showBottomNav;
  final int currentIndex;
  final Function(int)? onNavTap;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final PreferredSizeWidget? customAppBar;

  const BasePage({
    Key? key,
    required this.body,
    this.title,
    this.actions,
    this.showBackButton = false,
    this.showBottomNav = true,
    this.currentIndex = 0,
    this.onNavTap,
    this.floatingActionButton,
    this.backgroundColor,
    this.customAppBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      appBar: customAppBar ?? _buildAppBar(context),
      body: AnimatedSwitcher(
        duration: AppAnimations.medium,
        child: body,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
      ),
      bottomNavigationBar: showBottomNav && onNavTap != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.white,
                  height: 1.0,
                ),
                AppBottomNav(
                  currentIndex: currentIndex,
                  onTap: onNavTap!,
                ),
              ],
            )
          : null,
      floatingActionButton: floatingActionButton != null
          ? ScaleTransition(
              scale: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: ModalRoute.of(context)!.animation!,
                  curve: Curves.easeOut,
                ),
              ),
              child: floatingActionButton,
            )
          : null,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    if (title == null &&
        !showBackButton &&
        (actions == null || actions!.isEmpty)) {
      return PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(),
      );
    }

    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
      title: title != null
          ? Text(
              title!,
              style: AppStyles.heading2.copyWith(
                color: AppColors.secondary,
              ),
            )
          : null,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.secondary,
              ),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      actions: actions,
    );
  }
}
