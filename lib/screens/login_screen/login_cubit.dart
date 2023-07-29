import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iti_final_project/core/values_manager.dart';

import '../../core/font_manager.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool isRememberMe = false;
  bool isLoading = false;

  changeRememberMe() {
    isRememberMe = !isRememberMe;
    emit(LoginChangeRememberMeState());
  }

  Future<void> login({
    required BuildContext context,
  }) async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      isLoading = true;
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        )
            .then((value) {
          if (value.user!.emailVerified == false) {
            isLoading = false;
            AwesomeDialog(
                context: context,
                title: "Error",
                dialogType: DialogType.warning,
                padding: EdgeInsets.all(AppPadding.p20),
                body:  Text(
                  "Please Check your Email To verification email",
                  style: TextStyle(
                    fontSize: FontSize.s20,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                )).show();
            emit(LoginNotLoadingState());

            /////////utfjhd82
          } else {
            emit(LoginSuccessState());
          }
        });
      } on FirebaseAuthException catch (e) {
        emit(LoginErrorState(msg: e.toString()));
        if (e.code == 'user-not-found') {
          AwesomeDialog(
            context: context,
            title: "Error",
            body: const Text("No user found for that email"),
          ).show();
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
            context: context,
            padding: EdgeInsets.all(AppPadding.p20),
            title: "Error",
            body: Text(
              "Wrong password provided for that user",
              style: TextStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.medium,
              ),
            ),
          ).show();
        }
      }
    }
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}
