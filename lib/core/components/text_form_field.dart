import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color_manager.dart';
import '../font_manager.dart';
import '../values_manager.dart';


class CustomTextFormField extends StatefulWidget {
  final String name;
  final TextEditingController controller;
  bool isLastInput, isPassword,enable;
  final validator;
  final TextInputType keyboardType;
  final FormFieldSetter? onSave;
  final FocusNode? focusNode;
  VoidCallback? onEditingComplete;
   IconData? icon;

  CustomTextFormField({
    super.key,
    required this.name,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isLastInput = false,
    this.isPassword = false,
    this.validator,
    this.onSave,
    this.focusNode,
    this.onEditingComplete,
    this.enable= true,
     this.icon,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppPadding.p22),
      child: TextFormField(
        enabled:widget.enable,
        onEditingComplete: widget.onEditingComplete,
        focusNode: widget.focusNode,
        onSaved: widget.onSave,
        validator: widget.validator,
        controller: widget.controller,
        obscuringCharacter: '*',
        obscureText: widget.isPassword && isHidden,
        textInputAction:
        widget.isLastInput ? TextInputAction.done : TextInputAction.next,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
            prefixIconColor: ColorManager.primary,
            suffixIcon: widget.isPassword?GestureDetector(onTap: (){
              isHidden = !isHidden;
              setState((){});
            },
              child: Icon(isHidden?Icons.visibility_off: Icons.visibility),):null,
            hintText: widget.name,
            hintStyle: TextStyle(
              fontSize: FontSize.s14,
              color: ColorManager.brown,
              fontWeight: FontWeightManager.regular,
            ),
            filled: true,
            fillColor: ColorManager.grayLight,
            contentPadding: EdgeInsets.symmetric(
                vertical: AppPadding.p20, horizontal: AppPadding.p20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.sp),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }
}
