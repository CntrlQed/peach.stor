import 'base_viewmodel.dart';

class SignUpViewModel extends BaseViewModel {
  Future<void> createAccount() async {
    setState(ViewState.busy);
    // TODO: Implement account creation
    setState(ViewState.idle);
  }

  Future<void> signUpWithGoogle() async {
    setState(ViewState.busy);
    // TODO: Implement Google sign up
    setState(ViewState.idle);
  }
} 