import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNav({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.primary,
        selectedItemColor: AppColors.secondary,
        unselectedItemColor: AppColors.textLight,
        showUnselectedLabels: true,
        selectedLabelStyle: AppStyles.caption,
        unselectedLabelStyle: AppStyles.caption,
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          _buildNavItem(AppAssets.homeIcon, AppStrings.home),
          _buildNavItem(AppAssets.diversityIcon, AppStrings.categories),
          _buildNavItem(AppAssets.heartIcon, AppStrings.favorites),
          _buildNavItem(AppAssets.deliveryIcon, AppStrings.orders),
          _buildNavItem(AppAssets.personIcon, AppStrings.profile),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String iconPath, String label) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: AppAnimations.fast,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: currentIndex == _getIndexForLabel(label)
              ? AppColors.secondary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          iconPath,
          height: 24,
          color: currentIndex == _getIndexForLabel(label)
              ? AppColors.secondary
              : AppColors.textLight,
        ),
      ),
      label: label,
    );
  }

  int _getIndexForLabel(String label) {
    switch (label) {
      case AppStrings.home:
        return 0;
      case AppStrings.categories:
        return 1;
      case AppStrings.favorites:
        return 2;
      case AppStrings.orders:
        return 3;
      case AppStrings.profile:
        return 4;
      default:
        return 0;
    }
  }
}
