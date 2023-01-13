import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_expance/common_widget/button_widget.dart';
import 'package:money_expance/module/onbording_screen/onbording_screen.dart';
import 'package:money_expance/utilies/constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class EmailSentScreen extends StatefulWidget {
  String? email;

  EmailSentScreen({Key? key, this.email}) : super(key: key);

  @override
  State<EmailSentScreen> createState() => _EmailSentScreenState();
}

class _EmailSentScreenState extends State<EmailSentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 16, right: 16),
          children: [
            Image.asset(AppImage.forgetImage),
            const Text(
              'Your email is on the way',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.black100,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Check your email ${widget.email} and follow the instructions to reset your password',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.black50,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 30.h),
            button(
                context: context,
                text: 'Back to Login',
                onTap: () {
                  Get.offAll(const OnBordingScrren());
                }),
          ],
        ),
      ),
    );
  }
}
