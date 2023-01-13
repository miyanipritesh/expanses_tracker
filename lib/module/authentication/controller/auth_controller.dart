import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isError = false.obs;
  RxBool isObscureText = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
}
