import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../viewmodel/checkout_viewmodel.dart';
import '../widgets/base_page.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckoutViewModel>(
      create: (context) => CheckoutViewModel(),
      child: Consumer<CheckoutViewModel>(
        builder: (context, model, child) => BasePage(
          title: 'Checkout',
          showBackButton: true,
          showBottomNav: false,
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              _buildStepper(model),
              Expanded(
                child: PageView(
                  controller: model.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildAddressStep(model),
                    _buildPaymentStep(model),
                    _buildConfirmationStep(model),
                  ],
                ),
              ),
              _buildBottomBar(model, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepper(CheckoutViewModel model) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          for (int i = 0; i < 3; i++) ...[
            _buildStepCircle(
              i + 1,
              model.currentStep > i
                  ? StepState.complete
                  : model.currentStep == i
                      ? StepState.editing
                      : StepState.indexed,
            ),
            if (i < 2)
              Expanded(
                child: Container(
                  height: 2,
                  color: model.currentStep > i
                      ? AppColors.primary
                      : AppColors.textLight,
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildStepCircle(int step, StepState state) {
    final bool isActive = state == StepState.editing;
    final bool isComplete = state == StepState.complete;

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isComplete || isActive ? AppColors.primary : AppColors.textLight,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: isComplete
            ? const Icon(
                Icons.check,
                color: AppColors.secondary,
                size: 16,
              )
            : Text(
                step.toString(),
                style: AppStyles.body2.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildAddressStep(CheckoutViewModel model) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Address',
            style: AppStyles.heading2,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Full Name',
            onChanged: model.setFullName,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Address Line 1',
            onChanged: model.setAddressLine1,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Address Line 2',
            onChanged: model.setAddressLine2,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  label: 'City',
                  onChanged: model.setCity,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  label: 'Postal Code',
                  onChanged: model.setPostalCode,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStep(CheckoutViewModel model) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: AppStyles.heading2,
          ),
          const SizedBox(height: 16),
          _buildPaymentOption(
            icon: Icons.credit_card,
            title: 'Credit Card',
            subtitle: 'Pay with Visa, Mastercard, etc.',
            isSelected: model.selectedPaymentMethod == PaymentMethod.creditCard,
            onTap: () => model.setPaymentMethod(PaymentMethod.creditCard),
          ),
          const SizedBox(height: 16),
          _buildPaymentOption(
            icon: Icons.account_balance_wallet,
            title: 'Digital Wallet',
            subtitle: 'Pay with Google Pay, Apple Pay, etc.',
            isSelected:
                model.selectedPaymentMethod == PaymentMethod.digitalWallet,
            onTap: () => model.setPaymentMethod(PaymentMethod.digitalWallet),
          ),
          const SizedBox(height: 16),
          _buildPaymentOption(
            icon: Icons.payments_outlined,
            title: 'Cash on Delivery',
            subtitle: 'Pay when you receive your order',
            isSelected:
                model.selectedPaymentMethod == PaymentMethod.cashOnDelivery,
            onTap: () => model.setPaymentMethod(PaymentMethod.cashOnDelivery),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationStep(CheckoutViewModel model) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: AppStyles.heading2,
          ),
          const SizedBox(height: 16),
          _buildSummaryItem(
            title: 'Shipping Address',
            content: model.formattedAddress,
          ),
          const SizedBox(height: 16),
          _buildSummaryItem(
            title: 'Payment Method',
            content: model.formattedPaymentMethod,
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount:',
                style: AppStyles.body1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${AppStrings.price}2,500',
                style: AppStyles.heading2,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.body1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: AppStyles.body2,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.textLight,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textLight,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyles.body1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppStyles.body2.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(CheckoutViewModel model, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (model.currentStep > 0)
              Expanded(
                child: ElevatedButton(
                  style: AppStyles.secondaryButton,
                  onPressed: model.previousStep,
                  child: const Text('Previous'),
                ),
              ),
            if (model.currentStep > 0) const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                style: AppStyles.primaryButton,
                onPressed: () {
                  if (model.currentStep < 2) {
                    model.nextStep();
                  } else {
                    model.placeOrder(context);
                  }
                },
                child: Text(
                  model.currentStep < 2 ? 'Next' : 'Place Order',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
