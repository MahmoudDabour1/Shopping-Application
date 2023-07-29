import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_final_project/core/components/text_form_field.dart';
import 'package:iti_final_project/core/components/validation.dart';
import 'package:iti_final_project/core/font_manager.dart';
import 'package:iti_final_project/core/helper_method.dart';
import 'package:iti_final_project/core/string_manager.dart';
import 'package:iti_final_project/screens/login_screen/login_cubit.dart';
import 'package:iti_final_project/screens/login_screen/widgets/change_widget.dart';
import 'package:iti_final_project/screens/sign_up_screen/view.dart';
import '../../core/color_manager.dart';
import '../../core/values_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Builder(builder: (context) {
        final cubit = LoginCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppPadding.p125,
                            bottom: AppPadding.p36,
                          ),
                          child: Row(
                            children: [
                              Text(
                                StringManager.log,
                                style: TextStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s34,
                                  fontWeight: FontWeightManager.semiBold,
                                ),
                              ),
                              Text(
                                StringManager.i,
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s34,
                                  fontWeight: FontWeightManager.semiBold,
                                ),
                              )
                            ],
                          ),
                        ),
                        CustomTextFormField(
                          name: "Email",
                          controller: cubit.emailController,
                          validator: emailValidator,
                          focusNode: cubit.emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          icon: Icons.email,
                        ),
                        CustomTextFormField(
                          name: "Password",
                          controller: cubit.passwordController,
                          validator: passwordValidator,
                          focusNode: cubit.passwordFocusNode,
                          isPassword: true,
                          isLastInput: true,
                          keyboardType: TextInputType.visiblePassword,
                          icon: Icons.lock,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              StringManager.forgotPassword,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ),
                        ),
                        const ChangedLogin(),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 95.h,
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(AppRadius.r35),
                        topLeft: Radius.circular(AppRadius.r35)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringManager.doNotHaveAnAccount,
                        style: TextStyle(
                          fontSize: FontSize.s18,
                          color: ColorManager.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          navigatorTo(context: context, page: const SignUpScreen());
                        },
                        child: Text(
                          StringManager.signup,
                          style: TextStyle(
                            fontSize: FontSize.s18,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
