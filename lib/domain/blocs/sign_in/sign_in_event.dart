part of 'sign_in_bloc.dart';

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent.started() = _Started;

  const factory SignInEvent.signInWithEmail(
      {required String email, required String password}) = _SignInWithEmail;

  const factory SignInEvent.signInWithSocialNetwork() = _SignInWithSocialNetwork;
}
