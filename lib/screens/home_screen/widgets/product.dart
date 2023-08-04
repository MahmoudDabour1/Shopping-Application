import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iti_final_project/core/font_manager.dart';
import 'package:iti_final_project/core/values_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/color_manager.dart';

class TaskWidget extends StatefulWidget {
  final String name;
  final String description;
  final String id;
  final String image;
  final String price;
  final String category;
  final int count;

  const TaskWidget({
    Key? key,
    required this.name,
    required this.description,
    required this.id,
    required this.image,
    required this.price,
    required this.category,
    required this.count,
  }) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p10),
      child: InkWell(
        onLongPress: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
            padding: EdgeInsets.all(AppPadding.p20),
            body: Column(
              children: [
                Text(
                  "Do You Want To Delete This Product?",
                  style: TextStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary,
                      ),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('products')
                            .doc(widget.id)
                            .delete();
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            color: ColorManager.white,
                          ),
                          Text(
                            "Delete",
                            style: TextStyle(
                              color: ColorManager.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Cancel",
                            style: TextStyle(
                              color: ColorManager.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ).show();
        },
        onTap: () {},
        child: Container(
          height: 230.h,
          width: 150.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: ColorManager.primary,
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
            color: ColorManager.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Center(
                    child: LoadingAnimationWidget.discreteCircle(
                      size: 50,
                      color: ColorManager.primary,
                      secondRingColor: ColorManager.white,
                      thirdRingColor: ColorManager.black,
                    ),
                  ),
                  imageUrl: widget.image,
                  width: double.infinity,
                  height: 150.h,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Padding(
                padding: EdgeInsets.all(AppPadding.p14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s20,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        isLiked = !isLiked;
                        setState(() {});
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.heart,
                        color:
                            isLiked ? ColorManager.primary : ColorManager.gray,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$',
                      style: TextStyle(
                          color: ColorManager.primary,
                          fontWeight: FontWeightManager.bold,
                          fontSize: FontSize.s18),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      widget.price,
                      style: TextStyle(
                        color: ColorManager.primary,
                        fontWeight: FontWeightManager.bold,
                        fontSize: FontSize.s20,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Container(
                width: 100,
                height: 20,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Description: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorManager.white,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.bold,
                      // overflow: TextOverflow.visible
                    ),
                  // maxLines: 2,
                ),
              ),
              SizedBox(
                width: 200.w,
                child: Center(
                  child: Text(
                    widget.description,
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s20,
                      fontWeight: FontWeightManager.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
