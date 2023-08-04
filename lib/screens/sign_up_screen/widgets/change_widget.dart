import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/helper_method.dart';
import 'package:iti_final_project/screens/login_screen/view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../core/color_manager.dart';
import '../../../core/components/elevated_button.dart';
import '../../../core/font_manager.dart';
import '../../../core/string_manager.dart';
import '../../../core/values_manager.dart';
import '../sign_up_cubit.dart';

class ChangeSignUp extends StatelessWidget {
  const ChangeSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          navigatorTo(context: context, page: const LoginScreen());
          AwesomeDialog(
            context: context,
            title: "success",
            dialogType: DialogType.success,
            padding: EdgeInsets.all(AppPadding.p20),
            body: Text(
              "Send Email Verification\nPlease Check Your Email",
              style: TextStyle(
                fontSize: FontSize.s20,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
          ).show();
        }
      },
      builder: (context, state) {
        final cubit = SignUpCubit.get(context);
        if (state is SignUpLoadingState) {
          cubit.isLoading = true;
        }
        return Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: cubit.isAccept,
                  onChanged: (value) {
                    cubit.changeAccept();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                TextButton(
                  onPressed: (){
                    AwesomeDialog(
                      context: context,
                      title: "success",
                      dialogType: DialogType.success,
                      padding: EdgeInsets.all(AppPadding.p20),
                      body: Text(
                        StringManager.terms,
                        style: TextStyle(
                          fontSize: FontSize.s20,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ).show();
                  },
                 child: Text(StringManager.iAccept,
                  style: TextStyle(
                    fontSize: FontSize.s16,
                  ),)
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
                      name: StringManager.signup,
                      function: () async {
                        await cubit.signUp(context: context);
                      }),
            ),
          ],
        );
      },
    );
  }
}
