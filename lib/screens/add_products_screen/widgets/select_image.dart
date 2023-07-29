


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_final_project/screens/add_products_screen/add_products_cubit.dart';
import 'package:iti_final_project/screens/add_products_screen/widgets/bottom_model.dart';

import '../../../core/color_manager.dart';

class AddProductSelectImage extends StatelessWidget {
  const AddProductSelectImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductsCubit, AddProductsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = AddProductsCubit.get(context);
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                ),
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 150.h,
                    child: AddProductBottomModel(
                      cubit: cubit,
                    ),
                  );
                });
          },
          child: Container(
            width: 200.w,
            height: 200.h,
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
                  width: double.infinity,
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
