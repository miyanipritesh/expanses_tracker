import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_expance/common_widget/bottom_sheet.dart';
import 'package:money_expance/firebase/authentication.dart';
import 'package:money_expance/module/tabs/profile/controller/profile_controller.dart';
import 'package:money_expance/utilies/constant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // List navigation = [
    //   showBottomSheet1(
    //       onYes: (){},
    //       onNo: (){},
    //       title: 'Logout?',
    //       subTitle: 'Are you sure do you wanna logout?',
    //       context: context
    //   ),
    //   showBottomSheet1(
    //       onYes: (){},
    //       onNo: (){},
    //       title: 'Logout?',
    //       subTitle: 'Are you sure do you wanna logout?',
    //       context: context
    //   ),
    // ];
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 19, right: 19),
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      UnconstrainedBox(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: AppColors.violet100)),
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(AppImage.forgetImage),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Username',
                            style: TextStyle(
                                color: AppColors.lite20,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Iriana Saliha',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppColors.black50,
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: AppColors.lite60, width: 1)),
                      child: Image.asset(
                        AppIcon.edit,
                        height: 20,
                        width: 20,
                      ))
                ],
              ),
            ),
            Container(
              // height: 100,
              margin: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(25)),
              child: GetBuilder(
                init: ProfileController(),
                builder: (controller) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 7, bottom: 7),
                    shrinkWrap: true,
                    itemCount: controller.profileList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          index == controller.profileList.length - 1
                              ? showBottomSheet1(
                                  onYes: () {
                                    AuthenticationHelper().signOut();
                                  },
                                  onNo: () {
                                    Get.back();
                                  },
                                  title: 'Logout?',
                                  subTitle: 'Are you sure do you wanna logout?',
                                  context: context)
                              : Get.to(controller.navigation[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 7.0, bottom: 7, left: 17),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                    color: controller.profileList[index].title
                                                .toString() ==
                                            'Logout'
                                        ? AppColors.red100.withOpacity(0.20)
                                        : AppColors.violet20,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Center(
                                    child: Image.asset(
                                  controller.profileList[index].image
                                      .toString(),
                                  height: 20,
                                  width: 20,
                                )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                controller.profileList[index].title.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black50,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: AppColors.lite60,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
