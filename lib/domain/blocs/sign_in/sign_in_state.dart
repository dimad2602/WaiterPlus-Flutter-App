part of 'sign_in_bloc.dart';

@freezed
class SignInState with _$SignInState {
  const SignInState._();

  const factory SignInState.initial() = _Initial;

  const factory SignInState.loading() = _Loading;

  const factory SignInState.success({required RestaurantEmployee restaurantEmployee}) = _Success;

  const factory SignInState.failure({required String errorMessage}) = _Failure;

  // String? get errorMessage {
  //   return mapOrNull(
  //     failure: (value) => value.errorMessage,
  //   );
  // }

  // User? get user {
  //   return mapOrNull(
  //     success: (value) => value.user,
  //   );
  // }
}
