import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_final_project/core/components/text_form_field.dart';
import 'package:iti_final_project/core/components/validation.dart';
import 'package:iti_final_project/core/font_manager.dart';
import 'package:iti_final_project/core/helper_method.dart';
import 'package:iti_final_project/core/string_manager.dart';
import 'package:iti_final_project/screens/login_screen/view.dart';
import 'package:iti_final_project/screens/sign_up_screen/sign_up_cubit.dart';
import 'package:iti_final_project/screens/sign_up_screen/widgets/change_widget.dart';
import 'package:iti_final_project/screens/sign_up_screen/widgets/select_image.dart';
import '../../core/color_manager.dart';
import '../../core/values_manager.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Builder(builder: (context) {
        final cubit = SignUpCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 125.h, bottom: 20.h),
                          child: Row(
                            children: [
                              Text(
                                StringManager.sign,
                                style: TextStyle(
                                    color: ColorManager.primary,
                                    fontSize: FontSize.s34,
                                    fontWeight: FontWeightManager.semiBold),
                              ),
                              Text(
                                StringManager.up,
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s34,
                                  fontWeight: FontWeightManager.semiBold,
                                ),
                              ),
                              SizedBox(width: 50.w,),
                             const  SelectImage(),
                            ],
                          ),
                        ),
                        CustomTextFormField(
                          name: StringManager.userName,
                          validator: nameValidator,
                          controller: cubit.nameController,
                          focusNode: cubit.nameFocusNode,
                          icon: Icons.person,
                          keyboardType: TextInputType.name,
                        ),
                        CustomTextFormField(
                          name: StringManager.email,
                          validator: emailValidator,
                          controller: cubit.emailController,
                          focusNode: cubit.emailFocusNode,
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        CustomTextFormField(
                          name: StringManager.phone,
                          validator: phoneValidator,
                          controller: cubit.phoneController,
                          focusNode: cubit.phoneFocusNode,
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        CustomTextFormField(
                          name: StringManager.password,
                          validator: passwordValidator,
                          controller: cubit.passwordController,
                          focusNode: cubit.passwordFocusNode,
                          icon: Icons.lock,
                          isLastInput: true,
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                         const ChangeSignUp(),
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
                        topRight: Radius.circular(35.r),
                        topLeft: Radius.circular(35.r)),
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
                          navigatorTo(context: context, page: const LoginScreen());
                        },
                        child: Text(
                          StringManager.logIN,
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
