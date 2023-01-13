import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_expance/common_widget/button_widget.dart';
import 'package:money_expance/common_widget/text_widget.dart';
import 'package:money_expance/module/authentication/ui/log_in_screen.dart';
import 'package:money_expance/module/authentication/ui/sign_up_screen.dart';
import 'package:money_expance/module/onbording_screen/controller/onbording_controller.dart';
import 'package:money_expance/utilies/constant.dart';

class OnBordingScrren extends StatefulWidget {
  const OnBordingScrren({Key? key}) : super(key: key);

  @override
  State<OnBordingScrren> createState() => _OnBordingScrrenState();
}

class _OnBordingScrrenState extends State<OnBordingScrren> {
  OnBordingController onBordingController = Get.put(OnBordingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              flex: 8,
              child: PageView(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (pageIndex) {
                  onBordingController.currentPage.value = pageIndex;
                },
                children: [
                  ListView(
                    children: [
                      Image.asset(AppImage.o_1),
                      coustonText700(
                          text: 'Gain total control\n of your money'),
                      const SizedBox(
                        height: 16,
                      ),
                      coustonText500(
                          text:
                              'Become your own money manager\n and make every cent count')
                    ],
                  ),
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Image.asset(AppImage.o_2),
                      coustonText700(text: 'Know where your\n money goes'),
                      const SizedBox(
                        height: 16,
                      ),
                      coustonText500(
                          text:
                              'Track your transaction easily,\n with categories and financial report ')
                    ],
                  ),
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Image.asset(AppImage.o_3),
                      coustonText700(text: 'Planning ahead'),
                      const SizedBox(
                        height: 16,
                      ),
                      coustonText500(
                          text:
                              'Setup your budget for each category so you in control')
                    ],
                  ),
                ],
              )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            3,
                            (index) => Container(
                                  margin: const EdgeInsets.only(left: 16),
                                  height:
                                      onBordingController.currentPage.value ==
                                              index
                                          ? 16
                                          : 8,
                                  width:
                                      onBordingController.currentPage.value ==
                                              index
                                          ? 16
                                          : 8,
                                  decoration: BoxDecoration(
                                      color: onBordingController
                                                  .currentPage.value ==
                                              index
                                          ? AppColors.violet100
                                          : AppColors.violet20,
                                      borderRadius: BorderRadius.circular(8)),
                                )),
                      )),
                  const Spacer(),
                  button(
                      context: context,
                      text: 'Sign Up',
                      onTap: () {
                        Get.to(const SignUpScreen());
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  button2(
                      context: context,
                      text: 'Login',
                      onTap: () {
                        Get.to(const SignInScreen());
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ))
        ],
      )),
    );
  }
}
