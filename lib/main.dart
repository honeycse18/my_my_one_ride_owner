import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_ride_car_owner/utils/app_pages.dart';
import 'package:one_ride_car_owner/utils/app_singleton.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/theme.dart';

void main() async {
  await GetStorage.init();
  await Hive.initFlutter();
  await AppSingleton.instance.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const OneRideCarOwnerApp());
}

class OneRideCarOwnerApp extends StatelessWidget {
  const OneRideCarOwnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'OneRide Car Owner',
      getPages: AppPages.pages,
      initialRoute: AppPageNames.rootScreen,
      unknownRoute: AppPages.unknownScreenPageRoute,
      theme: AppThemeData.appThemeData,
    );
  }
}
