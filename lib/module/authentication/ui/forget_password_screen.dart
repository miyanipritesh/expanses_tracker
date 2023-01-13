import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:money_expance/common_widget/button_widget.dart';
import 'package:money_expance/common_widget/text_field_widget.dart';
import 'package:money_expance/firebase/authentication.dart';
import 'package:money_expance/module/authentication/controller/auth_controller.dart';
import 'package:money_expance/module/authentication/ui/password_foreget_sent_email.dart';
import 'package:money_expance/utilies/constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForGetPasswordScreen extends StatefulWidget {
  const ForGetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForGetPasswordScreen> createState() => _ForGetPasswordScreenState();
}

class _ForGetPasswordScreenState extends State<ForGetPasswordScreen> {
  AuthController authController = Get.find<AuthController>();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(AppIcon.arrowLeft)),
        ),
        centerTitle: true,
        title: const Text(
          'Forgot Password',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.black50,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 16, right: 16),
        children: [
          SizedBox(
            height: 15.h,
          ),
          const Text(
            'Don’t worry.\nEnter your email and we’ll send you a link to reset your password.',
            style: TextStyle(
                color: AppColors.black100,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFieldWidget(
            authController: authController,
            focusNode: focusNode,
            controller: authController.loginEmailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            textFieldType: TextFieldType.email,
          ),
          const SizedBox(
            height: 35,
          ),
          button(
              context: context,
              text: 'Continue',
              onTap: () {
                if (authController.loginEmailController.text.isEmail) {
                  Get.to(EmailSentScreen(
                    email: authController.loginEmailController.text,
                  ));
                  AuthenticationHelper()
                      .forgetPassword(
                          email: authController.loginPasswordController.text)
                      .then((value) {
                    if (value == '') {
                      Fluttertoast.showToast(
                          msg: 'Forget Password Link Send Successfully',
                          backgroundColor: AppColors.violet100,
                          textColor: AppColors.white);
                    } else {
                      Fluttertoast.showToast(
                          msg: value,
                          backgroundColor: AppColors.violet100,
                          textColor: AppColors.white);
                    }
                  });
                } else {
                  Fluttertoast.showToast(
                      msg: 'Pleases Enter Email',
                      backgroundColor: AppColors.violet100,
                      textColor: AppColors.white);
                }
              }),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
