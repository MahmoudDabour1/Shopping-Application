import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_final_project/screens/home_screen/widgets/scroller.dart';
import 'package:iti_final_project/screens/home_screen/widgets/select_category.dart';

import 'grid_view_data.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SafeArea(
        child: Column(
          children: [
            // SelectByCategory(),
            const HomeSlider(),
            SizedBox(
              height: 20.h,
            ),
             SizedBox(height:100,child: SelectByCategory()),
            const GridData(),
          ],
        ),
      ),
    );
  }
}
