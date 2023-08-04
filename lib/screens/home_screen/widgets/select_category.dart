import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_final_project/models/category_model.dart';

import '../../../core/color_manager.dart';
import '../../../core/font_manager.dart';

class SelectByCategory extends StatelessWidget {
   SelectByCategory({super.key});
  String? category;

  @override
  Widget build(BuildContext context,) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: model[index].onTap,
            child: Container(
              width: 100.w,
              clipBehavior: Clip.antiAlias,
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(60.r),
              ),
              child: Center(
                child: Stack(
                  clipBehavior: Clip.antiAlias,
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      model[index].image,
                      height: 100.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.8),
                        child: Text(
                          model[index].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorManager.white,
                            fontSize: FontSize.s20,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 10.w,
          );
        },
        itemCount: model.length);
  }
}
