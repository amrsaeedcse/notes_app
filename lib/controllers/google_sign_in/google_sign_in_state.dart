part of 'google_sign_in_cubit.dart';

@immutable
sealed class GoogleSignInState {}

final class GoogleSignInLoading extends GoogleSignInState {}

final class GoogleSignInFailure extends GoogleSignInState {
  String errorMessage;
  GoogleSignInFailure(this.errorMessage);
}

final class GoogleSignInSuccess extends GoogleSignInState {}
