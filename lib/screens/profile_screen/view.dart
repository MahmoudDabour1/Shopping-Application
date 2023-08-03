import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iti_final_project/screens/profile_screen/profile_cubit.dart';

import '../../core/color_manager.dart';
import '../../core/font_manager.dart';
import '../../core/string_manager.dart';
import '../../core/values_manager.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          email = userDoc.get('email');
          name = userDoc.get('name');
          phone = userDoc.get('mobileNo');
          image = userDoc.get('image');
        });
        User? user = auth.currentUser;
        String uid = user!.uid;
        setState(() {
          isSameUser = uid == widget.userId;
        });
      }
    } catch (error) {
      AwesomeDialog(
        context: context,
        padding: EdgeInsets.all(AppPadding.p20),
        title: "Error",
        dialogType: DialogType.error,
        body: Text(
          "No Data To Show",
          style: TextStyle(
            fontSize: FontSize.s16,
            fontWeight: FontWeightManager.medium,
          ),
        ),
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Builder(builder: (context) {
        final cubit = ProfileCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            titleSpacing: AppPadding.p22,
            backgroundColor: ColorManager.white,
            centerTitle: false,
            title: Text(
              StringManager.profile,
              style: TextStyle(
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.black,
                fontSize: FontSize.s24,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: AppPadding.p20),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.cartShopping,
                    color: ColorManager.black,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Card(
                margin: const EdgeInsets.all(30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: ColorManager.grayLight,
                child: Column(
                  children: [
                    Container(
                      width: 150.w,
                      height: 150.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: image != null
                          ? CachedNetworkImage(
                              imageUrl: image,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              "assets/images/person-icon-476x512-hr6biidg.png"),
                    ),
                    Text(
                      "Hi there $name",
                      style: TextStyle(
                        fontSize: FontSize.s22,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.brown,
                      ),
                    ),
                    MaterialButton(
                      color: ColorManager.primary,
                      onPressed: () {
                        cubit.signOut(context);
                      },
                      child: Text(
                        StringManager.signOut,
                        style: TextStyle(
                          fontSize: FontSize.s18,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(
                            "Email:   ",
                            style: TextStyle(
                              fontSize: FontSize.s16,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManager.primary,
                            ),
                          ),
                          SizedBox(
                            width: 180.w,
                            child: Text(
                              email,
                              style: TextStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.bold,
                                color: ColorManager.brown,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(
                            "Phone:   ",
                            style: TextStyle(
                              fontSize: FontSize.s16,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManager.primary,
                            ),
                          ),
                          Text(
                            phone,
                            style: TextStyle(
                              fontSize: FontSize.s16,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManager.brown,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(
                            "UID:   ",
                            style: TextStyle(
                              fontSize: FontSize.s16,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManager.primary,
                            ),
                            maxLines: 1,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              uid,
                              style: TextStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.bold,
                                color: ColorManager.brown,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
