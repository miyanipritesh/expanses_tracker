import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_expance/module/onbording_screen/onbording_screen.dart';
import 'package:money_expance/module/remote_config.dart';
import 'package:money_expance/module/tabs/home_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // LocalNotification.init();
  await Firebase.initializeApp();
  await GetStorage.init();
  await RemoteConfig1().initConfig();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("14199bf5-eea4-48b8-9a17-f3c73eb2f2bd");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            useMaterial3: true,
            primarySwatch: Colors.blue,
          ),
          home: FirebaseAuth.instance.currentUser?.uid != null
              ? const HomeScreen()
              : const OnBordingScrren(),
        );
      },
    );
  }
}
