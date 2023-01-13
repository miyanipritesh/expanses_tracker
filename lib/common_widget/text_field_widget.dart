import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:money_expance/module/authentication/controller/auth_controller.dart';
import 'package:money_expance/module/tabs/home/controller/expance_controller.dart';
import 'package:money_expance/utilies/constant.dart';

enum TextFieldType { email, password, matchPassword, user }

// ignore: must_be_immutable
class TextFieldWidget extends StatefulWidget {
  String? hintText;
  String? textFieldTitle;
  Function()? onEditingComplete;
  bool isPadding;
  TextInputType? keyboardType;
  ValueChanged<String>? onChanged;
  String? prefixIcon;
  String? fillPrefixIcon;
  Widget? prefixIconWidget;
  TextStyle? hintTextStyle;
  Widget? suffixIcon;
  Color? fillColor;
  Decoration? decoration;
  Widget? fillSuffixIcon;
  bool? isObscureText;
  bool? isPassWord;
  String? passWordSubtitle;
  String? fontFamily;
  TextFieldType? textFieldType;
  TextInputAction? textInputAction;
  TextEditingController? controller;
  TextEditingController? matchController;
  double? height;
  AuthController? authController;
  ExpanceController? expanceController;
  FocusNode? focusNode;
  bool autofocus;
  int? maxLines;
  int? maxInt;

  TextFieldWidget(
      {Key? key,
      this.controller,
      this.prefixIconWidget,
      this.maxInt,
      this.fillColor,
      this.hintTextStyle,
      this.decoration,
      this.authController,
      this.textFieldTitle,
      this.hintText,
      this.expanceController,
      this.keyboardType,
      this.onChanged,
      this.prefixIcon,
      this.height,
      this.fillPrefixIcon,
      this.suffixIcon,
      this.fillSuffixIcon,
      this.isObscureText = false,
      this.isPassWord = false,
      this.passWordSubtitle = "",
      this.textFieldType,
      this.textInputAction,
      this.fontFamily,
      this.focusNode,
      this.matchController,
      this.onEditingComplete,
      this.autofocus = false,
      this.maxLines,
      this.isPadding = false})
      : super(key: key);

  @override
  TextFieldWidgetState createState() => TextFieldWidgetState();
}

class TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(() {
      if (widget.controller!.text.isNotEmpty) {
        if (widget.textFieldType == TextFieldType.email) {
          if (widget.controller?.text.isEmail == true) {
            widget.authController?.isError.value = true;
          } else {
            widget.authController?.isError.value = false;
          }
        } else if (widget.textFieldType == TextFieldType.password) {
          if (widget.controller!.text.length >= 8) {
            widget.authController?.isError.value = true;
          } else {
            widget.authController?.isError.value = false;
          }
        } else if (widget.textFieldType == TextFieldType.user) {
          if (widget.controller!.text.isNotEmpty) {
            widget.authController?.isError.value = true;
          } else {
            widget.authController?.isError.value = false;
          }
        } else if (widget.textFieldType == TextFieldType.matchPassword) {
          if (widget.controller!.text.length < 8) {
            widget.authController?.isError.value = true;
          } else if (widget.controller!.text.length !=
              widget.matchController!.text.length) {
            widget.authController?.isError.value = true;
          }
        }
      } else {
        if (widget.authController?.isError.value == true) {
          widget.authController?.isError.value = false;
        }
      }

      // setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.focusNode?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  margin: EdgeInsets.only(
                      top: widget.isPadding ? 0 : 8,
                      bottom: widget.isPadding ? 0 : 6),
                  child: widget.textFieldTitle != null
                      ? Text(
                          '${widget.textFieldTitle}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lite20,
                          ),
                        )
                      : const SizedBox.shrink()),
              Container(
                  height: widget.height ?? 50,
                  decoration: widget.decoration ??
                      const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                  child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autofocus: widget.autofocus,
                      focusNode: widget.focusNode,
                      minLines: 1,
                      maxLines: widget.maxLines ?? 1,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: widget.keyboardType,
                      controller: widget.controller,
                      autocorrect: false,
                      scrollPadding: const EdgeInsets.symmetric(vertical: -5),
                      textAlign: TextAlign.start,
                      textInputAction: (widget.textInputAction != null)
                          ? widget.textInputAction
                          : TextInputAction.next,
                      obscureText: widget.isObscureText!,
                      obscuringCharacter: '●',
                      textAlignVertical: TextAlignVertical.center,
                      onEditingComplete: widget.onEditingComplete ?? () {},
                      inputFormatters: widget.maxInt != null
                          ? [LengthLimitingTextInputFormatter(widget.maxInt)]
                          : [],
                      style: const TextStyle(
                          // fontFamily: AppConstants.fontInter,
                          // fontSize: AppConstants.smallFont.sp,
                          // color: AppConstants.clrNero,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          fillColor: widget.fillColor ?? AppColors.white,
                          filled: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5),
                          hintText: widget.hintText ?? "",
                          hintStyle: widget.hintTextStyle ??
                              const TextStyle(
                                  // fontFamily: AppConstants.fontInter,
                                  fontSize: 16,
                                  color: AppColors.lite20,
                                  fontWeight: FontWeight.w500),
                          prefixIcon: widget.focusNode?.hasFocus == true
                              ? (widget.prefixIconWidget != null)
                                  ? widget.prefixIconWidget
                                  : (widget.fillPrefixIcon != null)
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 10),
                                          child: Image.asset(widget.fillPrefixIcon!,
                                              width: 20,
                                              color: AppColors.lite20))
                                      : const SizedBox.shrink()
                              : (widget.prefixIconWidget != null)
                                  ? widget.prefixIconWidget
                                  : (widget.prefixIcon != null)
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 10),
                                          child: Image.asset(widget.prefixIcon!,
                                              width: 20,
                                              color: AppColors.lite20))
                                      : const SizedBox.shrink(),
                          prefixIconConstraints:
                              const BoxConstraints(minWidth: 20, maxHeight: 20),
                          suffixIcon: widget.focusNode?.hasFocus == true
                              ? (widget.fillSuffixIcon != null)
                                  ? widget.fillSuffixIcon!
                                  : const SizedBox.shrink()
                              : (widget.suffixIcon != null)
                                  ? widget.suffixIcon!
                                  : const SizedBox.shrink(),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: (widget.authController?.isError.value == false)
                                      ? AppColors.lite20
                                      : AppColors.lite20)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: (widget.authController?.isError.value == false)
                                      ? AppColors.lite20
                                      : AppColors.lite20)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(width: 1, color: (widget.authController?.isError.value == false) ? Colors.red : AppColors.violet100)),
                          errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(width: 1, color: Colors.red))),
                      onChanged: (text) {
                        if (widget.onChanged != null) {
                          setState(() {});
                          widget.onChanged!(text);
                        }
                      })),
              widget.textFieldType != null &&
                      widget.textFieldType == TextFieldType.email &&
                      widget.authController?.isError.value == true
                  ? const SizedBox.shrink()
                  : const SizedBox.shrink(),
              widget.isPassWord!
                  ? Container(
                      margin: const EdgeInsets.only(top: 6),
                      child: const SizedBox.shrink())
                  : Container()
            ]));
  }
}
