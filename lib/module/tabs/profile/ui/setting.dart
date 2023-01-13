import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_expance/module/tabs/profile/controller/profile_controller.dart';
import 'package:money_expance/utilies/constant.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
          'Settings',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.black50,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: GetBuilder(
          init: ProfileController(),
          builder: (controller) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.settingList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    controller.settingList[index].title.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.black50,
                        fontSize: 16),
                  ),
                  trailing: SizedBox(
                    width:
                        controller.settingList[index].value == null ? 22 : 50,
                    child: Row(
                      children: [
                        controller.settingList[index].value == null
                            ? const SizedBox.shrink()
                            : Text(
                                controller.settingList[index].value.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.lite20,
                                    fontSize: 14),
                              ),
                        Image.asset(
                          AppIcon.arrowRight,
                          height: 20,
                          width: 20,
                          color: AppColors.violet100,
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
