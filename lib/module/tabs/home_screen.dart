import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_expance/common_widget/custom_paint.dart';
import 'package:money_expance/model/nav_model.dart';
import 'package:money_expance/module/tabs/controller/home_controller.dart';
import 'package:money_expance/utilies/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => homeController.tabs[homeController.selectBtn.value]),
        bottomNavigationBar: Obx(() => navigationBar()));
  }

  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      height: 70.0,
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft:
              Radius.circular(homeController.selectBtn.value == 0 ? 0.0 : 20.0),
          topRight: Radius.circular(
              homeController.selectBtn.value == navBtn.length - 1 ? 0.0 : 20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < navBtn.length; i++)
            GestureDetector(
              onTap: () => setState(() => homeController.selectBtn.value = i),
              child: iconBtn(i),
            ),
        ],
      ),
    );
  }

  Padding iconBtn(int i) {
    bool isActive = homeController.selectBtn.value == i ? true : false;
    var height = isActive ? 60.0 : 0.0;
    var width = isActive ? 50.0 : 0.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        width: 75.0,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: AnimatedContainer(
                height: height,
                width: width,
                duration: const Duration(milliseconds: 600),
                child: isActive
                    ? CustomPaint(
                        painter: ButtonNotch(),
                      )
                    : const SizedBox(),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                navBtn[i].imagePath,
                color: isActive ? AppColors.violet100 : AppColors.lite20,
                scale: 5,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                navBtn[i].name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isActive ? AppColors.violet100 : AppColors.lite20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
