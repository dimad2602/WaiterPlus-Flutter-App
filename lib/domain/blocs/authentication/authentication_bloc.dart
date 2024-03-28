import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_for_customers/domain/repositories/sign_in_repo/ISignInRepo.dart';
import 'package:flutter_app_for_customers/models/restaurant_employee/restaurant_employee.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ISignInRepository _repository;
  AuthenticationBloc(this._repository)
      : super(const AuthenticationState.unauthenticated()) {
    on<AuthenticationEvent>((event, emit) async {
      await event.map(
        userLoggedIn: (value) => _userLoggedIn(value, emit),
        userLoggedOut: (value) => _userLoggedOut(value, emit),
        started: (value) => _started(value, emit),
      );
    });
  }

  FutureOr<void> _started(_Started value, Emitter<AuthenticationState> emit) {
    print('AuthenticationState _started');
    //Проверить наличие токена из репозитория
    //Если валиден возвращаем user.info  иначе  кидаем страницу авторизации
    emit(const AuthenticationState.unauthenticated());
  }

  FutureOr<void> _userLoggedIn(
      _UserLoggedIn event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationState.authenticated(event.restaurantEmployee));
  }

  FutureOr<void> _userLoggedOut(
      _UserLoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationState.unauthenticated());
  }
}
