import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_for_customers/domain/repositories/sign_in_repo/ISignInRepo.dart';
import 'package:flutter_app_for_customers/models/restaurant_employee/restaurant_employee.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';
part 'sign_in_bloc.freezed.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final ISignInRepository _repository;
  SignInBloc(this._repository) : super(const SignInState.initial()) {
    on<SignInEvent>((event, emit) async {
      await event.map(
        started: (_) => _started(emit),
        signInWithEmail: (value) => _signInWithEmail(value, emit),
        signInWithSocialNetwork: (_) => _signInWithSocialNetwork(emit),
      );
    });
  }

  FutureOr<void> _started(Emitter<SignInState> emit) {
    emit(const SignInState.initial());
  }

  FutureOr<void> _signInWithEmail(
      _SignInWithEmail value, Emitter<SignInState> emit) async {
    try {
      // if (!_isValidEmail(value.email)) {
      //   emit(const SignInState.failure(errorMessage: 'Invalid email'));
      //   throw ValidationException('Invalid email');
      // } 
      // else if (!_isValidPassword(value.password)) {
      //   emit(const SignInState.failure(errorMessage: 'Invalid password'));
      //   throw ValidationException('Invalid password');
      // }

      emit(const SignInState.loading());
      
      final resultTest =
          await _repository.login(email: value.email, password: value.password);
      
      final result = await _repository.signInWithEmail(
          email: value.email, password: value.password);
      if (result != null) {
        emit(SignInState.success(restaurantEmployee: result));
      } else {
        emit(const SignInState.failure(
            errorMessage: 'Ошибка от сервера (не верные данные)'));
      }
    } catch (e) {
      if (e is ValidationException) {
        emit(SignInState.failure(errorMessage: e.message));
      } else {
        emit(SignInState.failure(errorMessage: 'Ошибка: $e'));
      }
    }
  }

  FutureOr<void> _signInWithSocialNetwork(Emitter<SignInState> emit) async {
    try {
      emit(const SignInState.loading());
      final result = await _repository.signInWithSocialNetwork();
      if (result != null) {
        emit(SignInState.success(restaurantEmployee: result));
      } else {
        emit(const SignInState.failure(errorMessage: ''));
      }
    } catch (e) {
      emit(SignInState.failure(errorMessage: '$e'));
    }
  }
}

class ValidationException implements Exception {
  final String message;

  ValidationException(this.message);
}

bool _isValidEmail(String email) {
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailRegex.hasMatch(email);
}

bool _isValidPassword(String password) {
  return password.length >= 6;
}
