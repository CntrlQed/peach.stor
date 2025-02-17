import 'base_viewmodel.dart';

class ChooseViewModel extends BaseViewModel {
  void onCarrierSelected() {
    // TODO: Implement carrier navigation
    setState(ViewState.busy);
    // Navigate to carrier screen
    setState(ViewState.idle);
  }
} 