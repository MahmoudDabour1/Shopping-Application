import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/category_model.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: List.generate(
        model.length,
            (index) => Image.asset(
          model[index].image,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      options: CarouselOptions(
        height: 250.0.h,
        autoPlay: true,
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(
          seconds: 3,
        ),
        autoPlayAnimationDuration: const Duration(
          seconds: 1,
        ),
        autoPlayCurve: Curves.fastOutSlowIn,
        initialPage: 0,
        reverse: false,
        scrollDirection: Axis.horizontal,
        viewportFraction: 1.0,
      ),
    );
  }
}
