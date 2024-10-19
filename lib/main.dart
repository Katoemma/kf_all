import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kijani_branch/app/modules/auth/controllers/auth_controller.dart';
import 'package:kijani_branch/app/modules/bc/bindings/bc_bindngs.dart';
import 'package:kijani_branch/app/modules/mel/bindings/bc_bindngs.dart';
import 'package:kijani_branch/app/modules/pmc/bindings/bc_bindngs.dart';
import 'package:kijani_branch/app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kijani Branches App',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.pages,
      initialBinding: BindingsBuilder(() {
        // Initialize AuthController globally on app launch
        Get.put(AuthController())
            .loadAuthData(); // Load authentication data on startup
        BcBinding().dependencies(); // Call the BC binding
        MelBinding().dependencies(); // Call the MEL binding
        PmcBinding().dependencies();
      }),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      unknownRoute: GetPage(
        name: '/notfound',
        page: () => const Scaffold(body: Center(child: Text('Page not found'))),
      ),
    );
  }
}
