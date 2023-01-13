import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:money_expance/common_widget/button_widget.dart';
import 'package:money_expance/common_widget/text_field_widget.dart';
import 'package:money_expance/firebase/authentication.dart';
import 'package:money_expance/module/authentication/controller/auth_controller.dart';
import 'package:money_expance/module/authentication/ui/forget_password_screen.dart';
import 'package:money_expance/module/authentication/ui/sign_up_screen.dart';
import 'package:money_expance/module/tabs/home_screen.dart';
import 'package:money_expance/utilies/constant.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthController authController = Get.put(AuthController());
  final focusNode = FocusNode();
  final focusNode1 = FocusNode();

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
          'Login',
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
          const SizedBox(
            height: 25,
          ),
          TextFieldWidget(
            authController: authController,
            focusNode: focusNode,
            controller: authController.loginEmailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            textFieldType: TextFieldType.email,
          ),
          Obx(() => TextFieldWidget(
                authController: authController,
                focusNode: focusNode1,
                controller: authController.loginPasswordController,
                hintText: 'Password',
                isPassWord: true,
                isObscureText: authController.isObscureText.value,
                textFieldType: TextFieldType.password,
                suffixIcon: IconButton(
                  icon: authController.isObscureText.value
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () {
                    authController.isObscureText.value =
                        !authController.isObscureText.value;
                  },
                ),
              )),
          const SizedBox(
            height: 35,
          ),
          button(
              context: context,
              text: 'Login',
              onTap: () {
                if (authController.loginEmailController.text.isEmail &&
                    authController.loginPasswordController.text.length >= 8) {
                  AuthenticationHelper()
                      .signIn(
                          email: authController.loginEmailController.text,
                          password: authController.loginPasswordController.text)
                      .then((value) {
                    if (value == true) {
                      Get.offAll(const HomeScreen());
                    } else {
                      Fluttertoast.showToast(
                          msg: value,
                          backgroundColor: AppColors.violet100,
                          textColor: AppColors.white);
                    }
                  });
                } else {
                  Fluttertoast.showToast(
                      msg: 'Pleases Enter Data',
                      backgroundColor: AppColors.violet100,
                      textColor: AppColors.white);
                }
              }),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Get.to(const ForGetPasswordScreen());
            },
            child: const Text(
              'Forgot Password?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.violet100,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25, bottom: 15),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Already have an account?',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lite20,
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => {Get.to(const SignUpScreen())},
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.violet100,
                      ),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
