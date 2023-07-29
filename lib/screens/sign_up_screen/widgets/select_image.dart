
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_final_project/screens/sign_up_screen/sign_up_cubit.dart';

import '../../../core/color_manager.dart';
import 'bottom_model.dart';

class SelectImage extends StatelessWidget {
  const SelectImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = SignUpCubit.get(context);
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 150.h,
                    child: SignUpBottomModel(
                      cubit: cubit,
                    ),
                  );
                });
          },
          child: Container(
            width: 150.w,
            height: 150.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(40),
              color: Colors.green.withOpacity(0.2),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                if (cubit.myImage != null)
                  Image.file(
                    cubit.myImage!,
                    height: 200.h,
                    width: 200.w,
                    fit: BoxFit.cover,
                  ),
                Container(
                  width: 150.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5)),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: cubit.myImage != null
                        ? ColorManager.white
                        : ColorManager.gray,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
