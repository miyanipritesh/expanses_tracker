import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_expance/model/profile_model.dart';
import 'package:money_expance/model/setting_model.dart';
import 'package:money_expance/model/user_model.dart';
import 'package:money_expance/module/tabs/profile/ui/setting.dart';
import 'package:money_expance/utilies/constant.dart';

class ProfileController extends GetxController {
  UserDetails? userDetails;
  final box = GetStorage();
  RxList<ProfileModel> profileList = <ProfileModel>[
    ProfileModel(title: 'Account', image: AppIcon.setting),
    ProfileModel(title: 'Logout', image: AppIcon.logOut),
  ].obs;
  RxList<SettingModel> settingList = <SettingModel>[
    SettingModel(title: 'Currency', value: 'USD'),
    SettingModel(title: 'About'),
    SettingModel(title: 'Help'),
  ].obs;

  List navigation = [
    const SettingScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
    userDetails = box.read(KeyConstant.userProfile);
    debugPrint('-------userDetails----->${box.read(KeyConstant.userProfile)}');
  }
}
