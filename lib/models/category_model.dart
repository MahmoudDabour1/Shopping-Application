
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iti_final_project/core/helper_method.dart';
import 'package:iti_final_project/screens/bottom_bar_screen/bottom_bar_cubit.dart';
import 'package:iti_final_project/screens/bottom_bar_screen/view.dart';

class CategoryModel {
  String name;
  String image;
 VoidCallback onTap;

  CategoryModel({
    required this.name,
    required this.image,
    required this.onTap,
  });
}
final cubit = BottomBarCubit.get(context);
BuildContext? context;


List<CategoryModel> model = [
  CategoryModel(name:"Foods", image: "assets/images/GettyImages-1301412050.webp", onTap: ()async{
    CollectionReference userRef = FirebaseFirestore.instance.collection("products");
    await userRef.where("category",isEqualTo: "Foods").get().then((value) => navigatorTo(context: context!, page:const BottomBarScreen() ));
    print("yes");
  }),
  CategoryModel(name:"Laptops", image: "assets/images/lab.webp", onTap: ()async{
    CollectionReference userRef = FirebaseFirestore.instance.collection("products");
    await userRef.where("category",isEqualTo: "Laptops").get();
  }),
  CategoryModel(name:"Mobiles", image: "assets/images/mobile.jpeg", onTap: ()async{
    CollectionReference userRef = FirebaseFirestore.instance.collection("products");
    await userRef.where("category",isEqualTo: "Mobiles").get();
  }),
  CategoryModel(name:"Clean", image: "assets/images/clean.jpeg", onTap: ()async{

  }),
  CategoryModel(name:"Books", image: "assets/images/book.jpg", onTap: ()async{
    CollectionReference userRef = FirebaseFirestore.instance.collection("products");
    await userRef.where("category",isEqualTo: "Books").get();
  }),
];
