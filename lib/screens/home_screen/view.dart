import 'package:flutter/material.dart';
import 'package:iti_final_project/core/font_manager.dart';
import 'package:iti_final_project/screens/home_screen/widgets/home_body.dart';

import '../../core/color_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? category;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorManager.primary,
        title: Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeightManager.bold,
            fontSize: FontSize.s28,
            color: ColorManager.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart_rounded,
              color: ColorManager.white,
            ),
          ),
        ],
      ),
      body: const HomeScreenBody(),
    );
  }
}
