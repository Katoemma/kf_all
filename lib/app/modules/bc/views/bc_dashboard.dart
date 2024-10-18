import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kijani_branch/app/data/providers/greetings.dart';
import 'package:kijani_branch/app/modules/auth/controllers/auth_controller.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the AuthController to get user data
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

                  final userData =
                      authController.userData; // Get the user data map

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
