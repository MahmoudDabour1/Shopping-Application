import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_final_project/core/color_manager.dart';
import 'package:iti_final_project/core/font_manager.dart';
import 'package:iti_final_project/core/values_manager.dart';

class AppDetails extends StatelessWidget {
  const AppDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorManager.primary,
        centerTitle: true,
        title: Text(
          "Developar Information",
          style: TextStyle(
            fontWeight: FontWeightManager.bold,
            color: ColorManager.white,
            fontSize: FontSize.s24,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p20,vertical: AppPadding.p20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Information",
                  style: TextStyle(
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.black,
                    fontSize: FontSize.s24,
                  ),
                ),
                Container(
                  height: 150.h,
                  width: 150.w,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Image.asset("assets/images/dab.png"),
                ),
              ],
            ),
            Card(
              child: Padding(
                padding:  const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    info(base: "name", data: "Mahmoud ElSaid Dabour"),
                    const Divider(thickness: 2,),
                    info(base: "Phone", data: "01099101469"),
                    const Divider(thickness: 2,),
                    info(base: "email", data: "Mahmoud.dabour1000000@gmail.com"),
                    const Divider(thickness: 2,),
                    info(base: "job", data: "Flutter Developer"),
                    const Divider(thickness: 2,),
                    info(base: "faculty", data: "Engineering"),
                    const Divider(thickness: 2,),
                    info(base: "university", data: "Mansoura University"),
                    const Divider(thickness: 2,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget info({required String base, required String data}){
  return Row(
    children: [
      Text('$base:  ',style: TextStyle(
        fontWeight: FontWeightManager.semiBold,
        color: ColorManager.primary,
        fontSize: FontSize.s18,
      ),
      ),
      const Spacer(),

      SizedBox(
        width: 200.w,
        child: Text(data,style: TextStyle(
          fontWeight: FontWeightManager.semiBold,
          color: ColorManager.black,
          fontSize: FontSize.s20,
          overflow: TextOverflow.visible,
        ),maxLines: 2,),
      ),

    ],
  );
}