import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_final_project/core/helper_method.dart';
import 'package:iti_final_project/screens/bottom_bar_screen/view.dart';
import 'package:iti_final_project/screens/login_screen/login_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../core/color_manager.dart';
import '../../../core/components/elevated_button.dart';
import '../../../core/font_manager.dart';
import '../../../core/string_manager.dart';
import '../../../core/values_manager.dart';

class ChangedLogin extends StatelessWidget {
  const ChangedLogin({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          navigatorTo(context: context, page:const BottomBarScreen(),withHistory: true);
        }
      },
      builder: (context, state) {
        final cubit = LoginCubit.get(context);
        return Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: cubit.isRememberMe,
                  onChanged: (value) {
                    cubit.changeRememberMe();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.r8),
                  ),
                ),
                Text(
                  StringManager.rememberMe,
                  style: TextStyle(
                    fontSize: FontSize.s16,
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: AppPadding.p58, bottom: AppPadding.p24),
              child: cubit.isLoading
                  ? LoadingAnimationWidget.discreteCircle(
                      size: 50,
                      color: ColorManager.primary,
                      secondRingColor: ColorManager.white,
                      thirdRingColor: ColorManager.black,
                    )
                  : CustomElevatedButton(
                      name: StringManager.logIN,
                      function: () async {
                        await cubit
                            .login(
                          context: context,
                        );
                      }),
            ),
            Text(
              StringManager.oR,
              style: TextStyle(
                fontSize: FontSize.s16,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppPadding.p36),
              child: Container(
                width: 70.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: ColorManager.grayLight,
                  borderRadius: BorderRadius.circular(AppRadius.r80),
                ),
                child: GestureDetector(
                  onTap: () async {
                    await cubit.signInWithGoogle().then((value) {
                      navigatorTo(context: context, page:const BottomBarScreen());
                    });
                  },
                  child: Image.asset(
                    "assets/images/google.png",
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
