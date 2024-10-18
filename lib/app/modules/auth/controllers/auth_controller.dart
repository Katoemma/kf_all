import 'package:airtable_crud/airtable_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kijani_branch/app/data/models/parish_model.dart'; // Assuming Parish model is defined
import 'package:kijani_branch/app/data/providers/userdata_provider.dart';
import 'package:kijani_branch/global/services/airtable_service.dart';
import 'package:kijani_branch/global/services/storage_service.dart';

class AuthController extends GetxController {
  final LocalStorage storageService = LocalStorage();
  final UserDataProvider userDataProvider =
      UserDataProvider(); // Instance of UserDataProvider

  var isAuthenticated = false.obs;
  var userRole = ''.obs;
  var userData = <String, dynamic>{}.obs; // Store user data as a map
  var parishData = <List<Parish>>[].obs;

  Future<void> login(String email, String password) async {
    try {
      // Define filters for each role
      var bcFilter = 'AND({BC-Email}="$email", {Branch-code}="$password")';
      var melFilter = 'AND({MEL-Email}="$email", {Branch-code}="$password")';
      var pmcFilter = 'AND({PMC Email}="$email", {Branch-code}="$password")';

      print('checking for bc');
      var bc = await nurseryBase.fetchRecordsWithFilter('parishes', bcFilter,
          view: 'To BC App');
      if (bc.isNotEmpty) {
        List<Parish> parishes =
            bc.map((record) => Parish.fromAirtable(record.fields)).toList();
        await _handleSuccessfulLogin(
            'bc', Map<String, dynamic>.from(bc.first.fields), parishes);
      } else {
        print('checking for mel');
        var mel = await nurseryBase
            .fetchRecordsWithFilter('parishes', melFilter, view: 'To BC App');
        if (mel.isNotEmpty) {
          List<Parish> parishes =
              mel.map((record) => Parish.fromAirtable(record.fields)).toList();
          await _handleSuccessfulLogin(
              'mel', Map<String, dynamic>.from(mel.first.fields), parishes);
        } else {
          print('checking for pmc');
          var pmc = await nurseryBase
              .fetchRecordsWithFilter('parishes', pmcFilter, view: 'To BC App');
          if (pmc.isNotEmpty) {
            List<Parish> parishes = pmc
                .map((record) => Parish.fromAirtable(record.fields))
                .toList();
            await _handleSuccessfulLogin(
                'pmc', Map<String, dynamic>.from(pmc.first.fields), parishes);
          } else {
            Get.snackbar(
              'Login Failed',
              'Invalid email or code',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        }
      }
    } on AirtableException catch (e) {
      Get.snackbar(
        'Login Failed',
        e.message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Helper function to handle successful login and store user data and parishes
  Future<void> _handleSuccessfulLogin(String role,
      Map<String, dynamic> userDataFromAirtable, List<Parish> parishes) async {
    userData.value = userDataFromAirtable; // Store the fetched user data
    isAuthenticated.value = true;
    userRole.value = role;

    await storageService.storeData(key: 'user', data: userDataFromAirtable);
    await storageService.setBool('isAuthenticated', true);
    await storageService.setString('userRole', userRole.value);

    // Fetch and store all hierarchical data for each parish
    await userDataProvider.fetchParishes(parishes);

    Get.offAllNamed(_getRedirectRoute());
  }

  // Function to load auth data from local storage on app startup
  Future<void> loadAuthData() async {
    isAuthenticated.value = await storageService.getBool('isAuthenticated');
    userRole.value = await storageService.getString('userRole');
    userData.value = await storageService.getData(key: 'user');
    if (isAuthenticated.value) {
      Get.offAllNamed(_getRedirectRoute());
    } else {
      Get.offAllNamed('/login');
    }
  }

  // Logout function to clear storage and reset auth state
  Future<void> logout() async {
    await storageService.removeEverything();
    isAuthenticated.value = false;
    userRole.value = '';
    userData.clear(); // Clear the user data
    Get.offAllNamed('/login');
  }

  // Determine the route to redirect based on the user's role
  String _getRedirectRoute() {
    return userRole.value == 'bc' ||
            userRole.value == 'pmc' ||
            userRole.value == 'mel'
        ? '/dashboard'
        : '/login';
  }
}
