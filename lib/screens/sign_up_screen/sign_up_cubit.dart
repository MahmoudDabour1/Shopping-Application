import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iti_final_project/core/values_manager.dart';
import '../../core/color_manager.dart';
import '../../core/font_manager.dart';
import '../../core/helper_method.dart';
import '../../models/user_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool isLoading = false;
  bool isAccept = false;
  File? myImage;
  String? url;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

   final user = FirebaseAuth.instance.currentUser;

  changeAccept() {
    isAccept = !isAccept;
    emit(SignUpChangeAcceptState());
  }

  void selectImage({ImageSource? source}) {
    ImagePicker.platform
        .getImage(
      source: source!,
    )
        .then((value) {
      if (value != null) {
        myImage = File(value.path);
        Navigator.pop(navigatorKey.currentContext!);
        emit(SignUpChangeImageState());
      }
    });
  }

 signUp({
  required BuildContext context,
}) async {
  if (formKey.currentState!.validate()) {
    if (isAccept) {
     if(myImage != null) {
       emit(SignUpLoadingState());
       try {
         await FirebaseAuth.instance.createUserWithEmailAndPassword(
           email: emailController.text.toLowerCase().trim(),
           password: passwordController.text.trim(),
         ).then((value) async{
           emit(SignUpSuccessState());
           final FirebaseAuth auth = FirebaseAuth.instance;
           final User? user = auth.currentUser;
           await user?.sendEmailVerification();
           final  uid = user!.uid;
           final ref = FirebaseStorage.instance.ref().child('user Image').child('${uid}jpg');
           await ref.putFile(myImage!);
           url = await ref.getDownloadURL();
           userCreate(
             name: nameController.text,
             uId: value.user!.uid,
             email: emailController.text,
             mobileNo: phoneController.text,
             image: url!.toString(),
           );
         });
       }on FirebaseAuthException catch (e) {
         emit(SignUpErrorState());
         if (e.code == 'weak_password') {
           AwesomeDialog(
               context: context,
               title: "Error",
               dialogType: DialogType.error,
               body: const Text("Password is too weak"))
               .show();
           isLoading = false;
         } else if (e.code == 'email-already-in-use') {
           AwesomeDialog(
               context: context,
               title: "Error",
               dialogType: DialogType.error,
               body: const Text("The account already exists for that email"))
               .show();
           isLoading = false;
         }
       } catch (e) {
         emit(SignUpErrorState());
         AwesomeDialog(
             context: context,
             dialogType: DialogType.error,
             title: "Error",
             padding: EdgeInsets.all(AppPadding.p20),
             body: Text(e.toString()))
             .show();
         isLoading = false;
       }
     }else{
       AwesomeDialog(
           context: context,
           dialogType: DialogType.error,
           title: "Error",
           padding: EdgeInsets.all(AppPadding.p20),
           body: Text("Please Select Image",style: TextStyle(
             fontSize: FontSize.s14,
             fontWeight: FontWeightManager.medium,
             color: ColorManager.black,
           ),))
           .show();
       isLoading = false;
     }
    } else{
      AwesomeDialog(
          context: context,
          padding: const EdgeInsets.all(
              20),
          dialogType: DialogType.question,
          body: Text(
            "Are you Accept Terms & Conditions",
            style: TextStyle(
              fontSize: FontSize.s14,
              fontWeight:
              FontWeightManager.medium,
            ),
          )).show();
      isLoading = false;
    }
  }
}


void userCreate({
  required String name,
  required String uId,
  required String email,
  required String mobileNo,
  required String image,
}) {
  UserDataModel model = UserDataModel(
    name: name,
    uId: uId,
    email: email,
    mobileNo: mobileNo,
     image : image,
  );
  FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap());
}


}