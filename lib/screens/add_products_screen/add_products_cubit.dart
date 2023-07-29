import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iti_final_project/core/color_manager.dart';
import 'package:iti_final_project/core/const.dart';
import 'package:iti_final_project/core/font_manager.dart';
import 'package:iti_final_project/core/string_manager.dart';
import 'package:iti_final_project/models/products_model.dart';
import 'package:uuid/uuid.dart';

import '../../core/helper_method.dart';
import '../../core/values_manager.dart';

part 'add_products_state.dart';

class AddProductsCubit extends Cubit<AddProductsState> {
  AddProductsCubit() : super(AddProductsInitial());

  static AddProductsCubit get(context) => BlocProvider.of(context);

  File? myImage;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? url;
  bool isLoading = false;


  void selectImage({ImageSource? source}) {
    ImagePicker.platform
        .getImage(
      source: source!,
    )
        .then((value) {
      if (value != null) {
        myImage = File(value.path);
        Navigator.pop(navigatorKey.currentContext!);
        emit(AddProductsTakeImageState());
      }
    });
  }

  showCategoryDialog(BuildContext context, size) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            StringManager.productCategory,
            style: TextStyle(
              color: ColorManager.primary,
              fontSize: FontSize.s20,
              fontWeight: FontWeightManager.bold,
            ),
          ),
          content: SizedBox(
            width: 30,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Constants.categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    categoryController.text = Constants.categoryList[index];
                    emit(AddProductsTakeCategoryState());
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
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
              },
            ),
          ),
        );
      },
    );
  }



  Future<dynamic> addProducts(BuildContext context) async {
    if(formKey.currentState!.validate()){
      if (myImage != null) {
        emit(AddProductsLoadingState());
        final  productId =  const Uuid().v4();
        try {
          final ref = FirebaseStorage.instance.ref()
              .child("products Image")
              .child('${productId}jpg');
          await ref.putFile(myImage!);
          url = await ref.getDownloadURL();
          productCreate(
            name: nameController.text,
            id:productId,
            category: categoryController.text,
            image: url!,
            price: priceController.text,
            description: descriptionController.text,);
          emit(AddProductsSuccessState());
        } catch (e) {
          emit(AddProductsErrorState());
          AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              title: "Error",
              padding: EdgeInsets.all(AppPadding.p20),
              body: Text(e.toString()))
              .show();
        }
      }  else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            title: "Error",
            padding: EdgeInsets.all(AppPadding.p20),
            body: Text("Please Select a Product Image",style: TextStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.medium,
              color: ColorManager.black,
            ),))
            .show();
      }
    }


      }

  void productCreate({
    required String name,
    required var id,
    required String category,
    required String image,
    required String price,
    required String description,
  }) {
    ProductsDataModel model = ProductsDataModel(
      name: name,
      category: category,
      id: id,
      image: image,
      description: description,
      price: price,
    );
    FirebaseFirestore.instance
        .collection("products")
        .doc(id)
        .set(model.toJson());
  }
}

