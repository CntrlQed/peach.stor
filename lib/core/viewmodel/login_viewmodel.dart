import 'base_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  Future<void> signIn() async {
    setState(ViewState.busy);
    // TODO: Implement sign in logic
    setState(ViewState.idle);
  }

  Future<void> signInWithGoogle() async {
    setState(ViewState.busy);
    // TODO: Implement Google sign in
    setState(ViewState.idle);
  }
} 