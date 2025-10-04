import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app/controllers/google_sign_in/google_sign_in_cubit.dart';
import 'package:note_app/helpers/theme/app_colors.dart';
import 'package:note_app/helpers/widgets/custom_text.dart';
import 'package:note_app/views/screens/create_note_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: BlocListener<GoogleSignInCubit, GoogleSignInState>(
        listener: (context, state) {
          if (state is GoogleSignInSuccess) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateNoteScreen()),
            );
          } else if (state is GoogleSignInFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.backGroundColor,
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CustomText(
                      data: state.errorMessage,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          } else if (state is GoogleSignInLoading) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: AppColors.backGroundColor,
                contentPadding: EdgeInsets.zero,
                content: SizedBox(
                  height: 200,
                  child: Center(
                    child: CupertinoActivityIndicator(
                      color: AppColors.backGroundColor,
                    ),
                  ),
                ),
              ),
            );
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                backgroundColor: AppColors.buttonBackGround,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                  side: BorderSide.none,
                ),
              ),
              onPressed: () {
                context.read<GoogleSignInCubit>().signInWithGoogle();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.google,
                    color: AppColors.backGroundColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
