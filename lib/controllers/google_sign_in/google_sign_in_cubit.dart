import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:note_app/fire_base/fire_auth.dart';

part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit() : super(GoogleSignInSuccess());
  FireAuth fireAuth = FireAuth();

  Future signInWithGoogle() async {
    try {
      emit(GoogleSignInLoading());
      await fireAuth.signInGoogle();
      emit(GoogleSignInSuccess());
    } on GoogleSignInException catch (e) {
      emit(GoogleSignInFailure(e.code.toString()));
    } catch (e) {
      emit(GoogleSignInFailure("error"));
    }
  }
}
