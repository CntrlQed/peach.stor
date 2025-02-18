import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ViewState {
  idle,
  busy,
  error,
  success,
}

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  String _errorMessage = '';

  ViewState get state => _state;
  String get errorMessage => _errorMessage;
  bool get isBusy => _state == ViewState.busy;

  void setState(ViewState viewState, [String? message]) {
    _state = viewState;
    if (message != null) {
      _errorMessage = message;
    }
    notifyListeners();
  }

  void setError(String message) {
    _errorMessage = message;
    _state = ViewState.error;
    notifyListeners();
  }

  void setBusy() {
    _state = ViewState.busy;
    notifyListeners();
  }

  void setIdle() {
    _state = ViewState.idle;
    notifyListeners();
  }

  void setSuccess([String? message]) {
    _state = ViewState.success;
    if (message != null) {
      _errorMessage = message;
    }
    notifyListeners();
  }
}
