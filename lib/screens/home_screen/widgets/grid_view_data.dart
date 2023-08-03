import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_final_project/core/font_manager.dart';
import 'package:iti_final_project/core/values_manager.dart';
import 'package:iti_final_project/screens/home_screen/widgets/product.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/color_manager.dart';
import '../../../core/const.dart';

class GridData extends StatefulWidget {
  const GridData({super.key});

  @override
  State<GridData> createState() => _GridDataState();
}

class _GridDataState extends State<GridData> {
  String? category;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('category', isEqualTo: category)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                size: 50,
                color: ColorManager.primary,
                secondRingColor: ColorManager.white,
                thirdRingColor: ColorManager.black,
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select By Category ", style: TextStyle(
                        fontSize: FontSize.s20,
                        color: ColorManager.black,
                        fontWeight: FontWeightManager.bold,
                      ),
                      ),
                      TextButton.icon(onPressed: (){
                        return showTaskCategoryDialog(context, size);
                      }, icon: Icon(Icons.keyboard_double_arrow_down_outlined,color: ColorManager.black,), label: Text("Select",style: TextStyle(
                        fontSize: FontSize.s20,
                        color: ColorManager.primary,
                        fontWeight: FontWeightManager.bold,
                      ),))
                    ],
                  ),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3.sp,
                    mainAxisSpacing: 2.sp,
                    childAspectRatio: 1 / 1.7,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                        snapshot.data!.docs.length,
                            (index) => TaskWidget(
                          name: snapshot.data!.docs[index]['name'],
                          description: snapshot.data!.docs[index]
                          ['description'],
                          id: snapshot.data!.docs[index]['id'],
                          image: snapshot.data!.docs[index]['image'],
                          category: snapshot.data!.docs[index]['category'],
                          price: snapshot.data!.docs[index]['price'],
                          count: snapshot.data!.docs.length,
                        )),
                  ),
                ],
              );
            } else {
              return  Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Select By Category ", style: TextStyle(
                          fontSize: FontSize.s20,
                          color: ColorManager.black,
                          fontWeight: FontWeightManager.bold,
                        ),
                        ),
                        TextButton.icon(onPressed: (){
                          return showTaskCategoryDialog(context, size);
                        }, icon: Icon(Icons.keyboard_double_arrow_down_outlined,color: ColorManager.black,), label: Text("Select",style: TextStyle(
                          fontSize: FontSize.s20,
                          color: ColorManager.primary,
                          fontWeight: FontWeightManager.bold,
                        ),))
                      ],
                    ),
                    const Center(child: Text('No tasks has been uploaded')),
                  ],
                ),
              );
            }
          }
          return const Center(
            child: Text('Something went wrong'),
          );
        });
  }

  void showTaskCategoryDialog(context, size) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Category',
              style: TextStyle(
                color: ColorManager.primary,
                fontSize: AppPadding.p20,
              ),
            ),
            content: SizedBox(
              width: size.width * 0.9,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Constants.categoryList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          category = Constants.categoryList[index];
                        });
                        Navigator.canPop(context)
                            ? Navigator.pop(context)
                            : null;
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: ColorManager.primary,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              Constants.categoryList[index],
                              style: TextStyle(
                                color: ColorManager.black,
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: const Text('Close'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    category = null;
                  });
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: const Text('Cancel filter'),
              ),
            ],
          );
        });
  }
}

// ListView.builder(
// itemCount: snapshot.data!.docs.length,
// itemBuilder: (BuildContext context, int index) {
// return TaskWidget(
// name: snapshot.data!.docs[index]['name'],
// description: snapshot.data!.docs[index]
// ['description'],
// id: snapshot.data!.docs[index]['id'],
// image: snapshot.data!.docs[index]['image'],
// category: snapshot.data!.docs[index]['category'],
// price: snapshot.data!.docs[index]['price'],
// count: snapshot.data!.docs.length,
// );
// });
