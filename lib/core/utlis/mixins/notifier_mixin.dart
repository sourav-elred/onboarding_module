import 'package:auth_module/core/utlis/failure.dart';
import 'package:flutter/material.dart';

enum AppState { initial, loading, error }

class ChangeNotifierState extends ChangeNotifier with NotifierState {}

mixin NotifierState on ChangeNotifier {
  AppState _state = AppState.initial;
  AppState get state => _state;

  Failure? _failure;
  Failure? get failure => _failure;

  void setState(AppState newState, [Failure? failure]) {
    if (newState == AppState.error && failure == null) {
      _state = newState;
      _failure = Failure('something went wrong');
    } else {
      _state = newState;
      _failure = failure;
    }
    notifyListeners();
  }
}
