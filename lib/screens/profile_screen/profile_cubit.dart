import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helper_method.dart';
import '../login_screen/view.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);

  Image? myImage;
  final formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  String email = "";
  String name = "";
  String phone = "";
  String image = "";

  String address = "";
  bool isSameUser = false;
  bool isEnable = false;
  bool isEdit = false;




  // Future<void> getUserData(String userId) async {
  //   try {
  //     final DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .get();
  //     if (userDoc == null) {
  //       return;
  //     } else {
  //         email = userDoc.get('email');
  //         name = userDoc.get('name');
  //         phone = userDoc.get('mobileNo');
  //         image = userDoc.get('image');
  //       User? user = auth.currentUser;
  //       String uid = user!.uid;
  //         isSameUser = uid == userId;
  //
  //         final emailController = TextEditingController(text: email);
  //         final nameController = TextEditingController(text: name);
  //         final addressController = TextEditingController(text: address);
  //         final phoneController = TextEditingController(text: phone);
  //         emit(ProfileGetDataState());
  //     }
  //   } catch (error) {}
  // }


  // void selectImage({ImageSource? source}) {
  //   ImagePicker.platform
  //       .getImage(
  //     source: source!,
  //   )
  //       .then((value) {
  //     if (value != null) {
  //       myImage = File(value.path);
  //       Navigator.pop(navigatorKey.currentContext!);
  //       emit(ProfileChangeImageState());
  //     }
  //   });
  // }




  signOut(BuildContext context) async {
    return await FirebaseAuth.instance.signOut().then((value) {
      navigatorTo(
        page: const LoginScreen(),
        context: context,
      );
    });
  }

  // void getUserData() async {
  //   try {
  //     final DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .get();
  //     if (userDoc == null) {
  //       return;
  //     } else {
  //         email = userDoc.get('email');
  //         name = userDoc.get('name');
  //         phone = userDoc.get('phone');
  //
  //       User? user = auth.currentUser;
  //       String uid = user!.uid;
  //       setState(() {
  //         isSameUser = uid == widget.userId;
  //       });
  //     }
  //   } catch (error) {}
  // }

  
  

//  setImage(){
//   if (myImage != null)
//     Image.file(
//       myImage!,
//       height: 200.h,
//       width: 200.w,
//       fit: BoxFit.cover,
//     );
//   emit(ProfileSetImageState());
// }
}
