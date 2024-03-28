part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.started() = _Started;
  const factory AuthenticationEvent.userLoggedIn(RestaurantEmployee restaurantEmployee) = _UserLoggedIn;
  const factory AuthenticationEvent.userLoggedOut() = _UserLoggedOut;
}