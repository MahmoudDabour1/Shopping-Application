import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/color_manager.dart';
import '../../../../core/font_manager.dart';
import '../../../../core/values_manager.dart';
import '../../../models/on_boarding_model.dart';
import '../on_boarding_cubit.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = OnBoardingCubit.get(context);
        return PageView.builder(
          controller: cubit.pageController,
          onPageChanged: cubit.onPageChanged,
          itemCount: onBoardingList.length,
          itemBuilder: (context, i) =>
              Column(
                children: [
                  Padding(
                    padding:
                    EdgeInsets.only(
                        top: AppPadding.p112, bottom: AppPadding.p30),
                    child: Image.asset(
                      onBoardingList[i].image,
                      width: 241.25.w,
                      height: 305.h,
                    ),
                  ),
                  SizedBox(
                    height: AppPadding.p30,
                  ),
                  Text(
                    onBoardingList[i].title,
                    style: TextStyle(
                      fontSize: AppSize.s28,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.brown,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: AppPadding.p33,),
                    child: Text(
                      onBoardingList[i].description,
                      style: TextStyle(
                        fontSize: AppSize.s13,
                        fontWeight: FontWeightManager.regular,
                        color: ColorManager.brown,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
        );
      },
    );
  }
}
