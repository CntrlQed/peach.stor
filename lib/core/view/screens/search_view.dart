import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../viewmodel/search_viewmodel.dart';
import '../widgets/base_page.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      create: (context) => SearchViewModel(),
      child: Consumer<SearchViewModel>(
        builder: (context, model, child) => BasePage(
          showBackButton: true,
          showBottomNav: false,
          backgroundColor: AppColors.background,
          customAppBar: _buildSearchAppBar(model, context),
          body: Column(
            children: [
              _buildFilters(model),
              Expanded(
                child: model.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : model.searchResults.isEmpty
                        ? _buildEmptyState(model.searchQuery.isEmpty)
                        : _buildSearchResults(model),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildSearchAppBar(
    SearchViewModel model,
    BuildContext context,
  ) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: AnimatedContainer(
        duration: AppAnimations.fast,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          onChanged: model.onSearchQueryChanged,
          decoration: InputDecoration(
            hintText: 'Search products...',
            hintStyle: AppStyles.body2.copyWith(color: AppColors.textLight),
            prefixIcon: const Icon(Icons.search, color: AppColors.textLight),
            suffixIcon: model.searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: AppColors.textLight),
                    onPressed: model.clearSearch,
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilters(SearchViewModel model) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip(
            label: 'All',
            isSelected: model.selectedCategory == null,
            onSelected: (_) => model.setCategory(null),
          ),
          const SizedBox(width: 8),
          ...model.categories.map(
            (category) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildFilterChip(
                label: category,
                isSelected: model.selectedCategory == category,
                onSelected: (_) => model.setCategory(category),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required Function(bool) onSelected,
  }) {
    return FilterChip(
      label: Text(
        label,
        style: AppStyles.body2.copyWith(
          color: isSelected ? AppColors.secondary : AppColors.text,
        ),
      ),
      selected: isSelected,
      onSelected: onSelected,
      backgroundColor: AppColors.secondary,
      selectedColor: AppColors.primary,
      checkmarkColor: AppColors.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.textLight,
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isInitial) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isInitial ? Icons.search : Icons.search_off,
            size: 64,
            color: AppColors.textLight,
          ),
          const SizedBox(height: 16),
          Text(
            isInitial ? 'Search for products' : 'No products found',
            style: AppStyles.heading2,
          ),
          const SizedBox(height: 8),
          Text(
            isInitial
                ? 'Type something to start searching'
                : 'Try different keywords or filters',
            style: AppStyles.body2.copyWith(color: AppColors.textLight),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(SearchViewModel model) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: model.searchResults.length,
      itemBuilder: (context, index) {
        final product = model.searchResults[index];
        return AnimatedScale(
          duration: AppAnimations.fast,
          scale: 1.0,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () => model.onProductTapped(context, product),
              borderRadius: BorderRadius.circular(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: Image.asset(
                      product.imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: AppStyles.body1.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${AppStrings.price}${product.price}',
                          style: AppStyles.body2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
