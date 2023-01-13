import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:money_expance/common_widget/button_widget.dart';
import 'package:money_expance/common_widget/text_field_widget.dart';
import 'package:money_expance/firebase/authentication.dart';
import 'package:money_expance/firebase/databs.dart';
import 'package:money_expance/module/authentication/controller/auth_controller.dart';
import 'package:money_expance/module/authentication/ui/log_in_screen.dart';
import 'package:money_expance/module/tabs/home_screen.dart';
import 'package:money_expance/utilies/constant.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthController authController = Get.put(AuthController());
  final focusNode = FocusNode();
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();

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
          'Sign Up',
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
            controller: authController.nameController,
            hintText: 'Name',
            textFieldType: TextFieldType.user,
            keyboardType: TextInputType.name,
            passWordSubtitle: "Paasword lenght must be 8",
          ),
          TextFieldWidget(
            authController: authController,
            focusNode: focusNode1,
            controller: authController.emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            textFieldType: TextFieldType.email,
          ),
          Obx(() => TextFieldWidget(
                authController: authController,
                focusNode: focusNode2,
                controller: authController.passwordController,
                hintText: 'Password',
                isPassWord: true,
                isObscureText: true,
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
              text: 'Sign Up',
              onTap: () {
                if (authController.nameController.text.isNotEmpty &&
                    authController.emailController.text.isEmail &&
                    authController.passwordController.text.length >= 8) {
                  AuthenticationHelper()
                      .signUp(
                          email: authController.emailController.text,
                          password: authController.passwordController.text)
                      .then((value) {
                    if (value == true) {
                      Get.offAll(const HomeScreen());
                      FirebaseDatabase().setData(
                          password: authController.passwordController.text,
                          email: authController.emailController.text,
                          name: authController.nameController.text);
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
            height: 15,
          ),
          const Text(
            'Or with',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.lite20,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 56,
            width: MediaQuery.of(context).size.width * 0.90,
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.white)),
                onPressed: () {
                  AuthenticationHelper.signInWithGoogle();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppIcon.google,
                      height: 32,
                      width: 32,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Sign Up with Google',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.black100,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 35, bottom: 15),
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
                      text: 'Login',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => {Get.to(const SignInScreen())},
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
