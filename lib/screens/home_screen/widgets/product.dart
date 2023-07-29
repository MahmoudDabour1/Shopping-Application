import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_final_project/core/font_manager.dart';
import 'package:iti_final_project/core/values_manager.dart';

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.5;

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
          height: 200.h,
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: ColorManager.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  width: 100,
                  height: 200.h,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s24,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Price: ",
                        style: TextStyle(
                          color: ColorManager.primary,
                          fontSize: FontSize.s20,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        widget.price,
                        style: TextStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s20,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                    ],
                  ),
                  // Divider(
                  //   thickness: 2,
                  // ),
                  Text(
                    "Description: ",
                    style: TextStyle(
                        color: ColorManager.primary,
                        fontSize: FontSize.s20,
                        fontWeight: FontWeightManager.semiBold,
                        overflow: TextOverflow.visible),
                    maxLines: 2,
                  ),
                  SizedBox(
                    width: 200.w,
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

                ],
              ),

              // ListTile(
              //   onTap: () {},
              //   onLongPress: () {
              //     AwesomeDialog(
              //       context: context,
              //       dialogType: DialogType.question,
              //       padding: EdgeInsets.all(AppPadding.p20),
              //       body: Column(
              //         children: [
              //           Text(
              //             "Do You Want To Delete This Product?",
              //             style: TextStyle(
              //               color: ColorManager.black,
              //               fontSize: FontSize.s14,
              //               fontWeight: FontWeightManager.semiBold,
              //             ),
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: [
              //               TextButton(
              //                 style: ElevatedButton.styleFrom(
              //                   backgroundColor: ColorManager.primary,
              //                 ),
              //                 onPressed: () {
              //                   FirebaseFirestore.instance
              //                       .collection('products')
              //                       .doc(widget.id)
              //                       .delete();
              //                   Navigator.pop(context);
              //                 },
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     Icon(
              //                       Icons.delete,
              //                       color: ColorManager.white,
              //                     ),
              //                     Text(
              //                       "Delete",
              //                       style: TextStyle(
              //                         color: ColorManager.white,
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //               TextButton(
              //                 style: ElevatedButton.styleFrom(
              //                   backgroundColor: ColorManager.primary,
              //                 ),
              //                 onPressed: () {
              //                   Navigator.pop(context);
              //                 },
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     Text(
              //                       "Cancel",
              //                       style: TextStyle(
              //                         color: ColorManager.white,
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ).show();
              //   },
              //   contentPadding:
              //   const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   leading: Container(
              //     padding: const EdgeInsets.only(right: 12),
              //     decoration: const BoxDecoration(
              //       border: Border(
              //         right: BorderSide(width: 1),
              //       ),
              //     ),
              //     child: CircleAvatar(
              //       backgroundColor: Colors.transparent,
              //       radius: 25,
              //       child: Image.network(widget.image),
              //     ),
              //   ),
              //   title: Text(
              //     widget.name,
              //     overflow: TextOverflow.ellipsis,
              //     style: const TextStyle(
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              //   subtitle: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Icon(
              //         Icons.linear_scale,
              //         color: Colors.pink.shade800,
              //       ),
              //       Text(
              //         widget.description,
              //         maxLines: 2,
              //         overflow: TextOverflow.ellipsis,
              //         style: const TextStyle(
              //           fontSize: 16,
              //         ),
              //       ),
              //     ],
              //   ),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right,
              //     size: 30,
              //     color: Colors.pink[800],
              //   ),
              // ),
              //
              // Container(
              //   height:100.h ,
              //   width: double.infinity,
              //   clipBehavior: Clip.antiAlias,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(30.r),
              //   ),
              //   child: Image.network(widget.image,),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
