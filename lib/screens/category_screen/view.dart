import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_final_project/core/font_manager.dart';
import 'package:iti_final_project/core/string_manager.dart';
import 'package:iti_final_project/core/values_manager.dart';
import 'package:iti_final_project/models/category_model.dart';

import '../../core/color_manager.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringManager.category,
                  style: TextStyle(
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s28,
                    color: ColorManager.primary,
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                     onTap: model[index].onTap,
                      child: Container(
                        width: double.infinity,
                        height: AppSize.s88,
                        decoration: BoxDecoration(
                          color: ColorManager.grayLight,
                          borderRadius: BorderRadius.circular(AppRadius.r35),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.red

                              ),
                              child: Image.asset(
                                model[index].image,
                                fit: BoxFit.fill,

                              ),
                            ),
                            Text(
                              model[index].name,
                              style: TextStyle(
                                fontSize: FontSize.s28,
                                fontWeight: FontWeightManager.bold,
                                color: ColorManager.black,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 30,
                              color: ColorManager.black,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 30.h,
                    );
                  },
                  itemCount: model.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
