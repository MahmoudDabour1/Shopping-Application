import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_final_project/core/color_manager.dart';
import 'package:iti_final_project/core/font_manager.dart';
import 'package:iti_final_project/core/string_manager.dart';
import 'package:iti_final_project/core/values_manager.dart';
import 'package:iti_final_project/screens/on_boarding_screen/view.dart';

import '../../core/helper_method.dart';
import '../bottom_bar_screen/view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  {

  @override
  void initState() {
    super.initState();
    late bool isLogin;
    var user = FirebaseAuth.instance.currentUser;
    if(user == null){
      isLogin = false;
    }else{
      isLogin = true;
    }
    Timer(const Duration(seconds: 3),(){
      navigatorTo(page: isLogin==true ?const BottomBarScreen():const OnBoardingScreen(),context: context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: ColorManager.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 210.w,
              height: 61.h,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(5.r)),
              child: Text(StringManager.welcome,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorManager.white,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s28,
                  )),
            ),

            Padding(
              padding:  EdgeInsets.only(top: AppPadding.p14,bottom: 100),
              child: Container(
                width: 257.w,
                height: 61.h,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(5.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(StringManager.shopping,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorManager.primary,
                          fontWeight: FontWeightManager.bold,
                          fontSize: FontSize.s28,
                        )),
                    SizedBox(width: 10.w,),
                    Text(StringManager.app,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorManager.white,
                          fontWeight: FontWeightManager.bold,
                          fontSize: FontSize.s28,
                        )),
                  ],
                ),
              ),
            ),
            Image.asset("assets/images/img_4.png",width: 200.w,height: 200.h,),
          ],
        ),
      ),
    );
  }
}
