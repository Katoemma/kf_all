import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kijani_branch/app/data/providers/greetings.dart';
import 'package:kijani_branch/app/modules/auth/controllers/auth_controller.dart';
import 'package:kijani_branch/global/enums/colors.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/kijani_logo.png',
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff23566d),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) async {
              if (value == 'logout') {
                authController.logout();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  TimeProvider().greeting(),
                  style: const TextStyle(fontSize: 20),
                ),

                // Display user data
                Obx(() {
                  if (authController.userData.isEmpty) {
                    return const Text('No user data available');
                  }

                  final userData = authController.userData;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${userData['BC-Name'] ?? 'N/A'}',
                        style: const TextStyle(
                          color: Color(0xff23566d),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${userData['Branch']}",
                        style: const TextStyle(
                          color: Color(0xff23566d),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 40),
                // Show parishes data
                Obx(() {
                  if (authController.parishData.isEmpty) {
                    return const Text('No parishes data available');
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: authController.parishData.length,
                    itemBuilder: (context, index) {
                      final parish = authController.parishData[index];
                      return GestureDetector(
                        onTap: () => Get.toNamed('/parish', arguments: parish),
                        child: Container(
                          color: kfBlue,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            parish.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
