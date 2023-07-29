import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iti_final_project/core/font_manager.dart';
import 'package:iti_final_project/core/values_manager.dart';
import 'package:iti_final_project/screens/home_screen/widgets/product.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/color_manager.dart';
import '../../core/const.dart';

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
        centerTitle: true,
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
          TextButton(
            onPressed: () {
              return showTaskCategoryDialog(context, size);
            },
            child: Row(
              children: [
                Icon(
                  Icons.keyboard_double_arrow_down,
                  color: ColorManager.white,
                ),
                Text("Filter",
                  style: TextStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s20,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
              ],
            ),

          ),
        ],
      ),
      body: Scaffold(
        backgroundColor: Colors.grey[400],
        body: StreamBuilder<QuerySnapshot>(
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
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskWidget(
                          name: snapshot.data!.docs[index]['name'],
                          description: snapshot.data!.docs[index]
                              ['description'],
                          id: snapshot.data!.docs[index]['id'],
                          image: snapshot.data!.docs[index]['image'],
                          category: snapshot.data!.docs[index]['category'],
                          price: snapshot.data!.docs[index]['price'],
                          count: snapshot.data!.docs.length,
                        );
                      });
                } else {
                  return const Center(
                    child: Center(child: Text('No tasks has been uploaded')),
                  );
                }
              }
              return const Center(
                child: Text('Something went wrong'),
              );
            }),
      ),
    );
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
