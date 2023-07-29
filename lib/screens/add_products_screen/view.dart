import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/color_manager.dart';
import 'package:iti_final_project/core/components/elevated_button.dart';
import 'package:iti_final_project/core/components/text_form_field.dart';
import 'package:iti_final_project/core/components/validation.dart';
import 'package:iti_final_project/core/string_manager.dart';
import 'package:iti_final_project/core/values_manager.dart';
import 'package:iti_final_project/screens/add_products_screen/add_products_cubit.dart';
import 'package:iti_final_project/screens/add_products_screen/widgets/select_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/font_manager.dart';

class AddProductsScreen extends StatelessWidget {
  const AddProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AddProductsCubit(),
      child: Builder(builder: (context) {
        final cubit = AddProductsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: ColorManager.primary,
            centerTitle: true,
            title: Text(
              "Add Products",
              style: TextStyle(
                color: ColorManager.white,
                fontSize: FontSize.s22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: BlocConsumer<AddProductsCubit, AddProductsState>(
              listener: (context, state) {
                if (state is AddProductsSuccessState) {
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      padding: EdgeInsets.all(AppPadding.p20),
                      body: Text(
                        "Products Added Successfully",
                        style: TextStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.medium,
                          color: ColorManager.black,
                        ),
                      )).show();
                  cubit.nameController.clear();
                  cubit.categoryController.clear();
                  cubit.priceController.clear();
                  cubit.descriptionController.clear();
                  cubit.isLoading = false;
                }
                if (state is AddProductsLoadingState) {
                  cubit.isLoading = true;
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        SizedBox(height: AppPadding.p20,),
                        const AddProductSelectImage(),
                        CustomTextFormField(
                          name: StringManager.productName,
                          controller: cubit.nameController,
                          validator: nameValidator,
                        ),
                        GestureDetector(
                          onTap: () {
                            cubit.showCategoryDialog(context, size);
                          },
                          child: CustomTextFormField(
                            name: StringManager.productCategory,
                            controller: cubit.categoryController,
                            enable: false,
                            // fct: cubit.showCategoryDialog(context, size),
                          ),
                        ),
                        CustomTextFormField(
                          name: StringManager.productPrice,
                          controller: cubit.priceController,
                          validator: nameValidator,
                        ),
                        CustomTextFormField(
                          name: StringManager.productDescription,
                          controller: cubit.descriptionController,
                          validator: nameValidator,
                        ),
                        SizedBox(
                          height: AppPadding.p10,
                        ),
                        cubit.isLoading
                            ? LoadingAnimationWidget.discreteCircle(
                                size: 50,
                                color: ColorManager.primary,
                                secondRingColor: ColorManager.white,
                                thirdRingColor: ColorManager.black,
                              )
                            : CustomElevatedButton(
                                name: StringManager.addProducts,
                                function: () {
                                  cubit.addProducts(context);
                                },
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
