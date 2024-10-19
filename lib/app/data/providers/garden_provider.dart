import 'dart:convert';
import 'package:airtable_crud/airtable_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:kijani_branch/app/data/models/farmer.dart';
import 'package:kijani_branch/app/data/models/garden.dart';
import 'package:kijani_branch/global/services/airtable_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GardenProvider extends GetxController {
  List<Garden> gardens = [];

  Future<List<Garden>?> fetchGardensForFarmer(Farmer farmer) async {
    if (kDebugMode) {
      print('Fetching gardens for farmer: ${farmer.name}');
    }
    try {
      var response = await currentGardenBase.fetchRecordsWithFilter(
          'Gardens', 'AND({FarmerID} = "${farmer.id}-${farmer.name}")');
      List<Garden> fetchedGardens =
          response.map((record) => Garden.fromJson(record.fields)).toList();

      // Save fetched gardens to local list and SharedPreferences
      gardens.addAll(fetchedGardens);
      await _saveGardensToSharedPreferences(fetchedGardens);

      return fetchedGardens;
    } on AirtableException catch (e) {
      if (kDebugMode) {
        print(e.message + e.details!);
      }
    } catch (e) {
      if (kDebugMode) {
        print("FETCH GARDEN ERROR: ${e.toString()}");
      }
    }
    return null;
  }

  Future<Garden?> getGardenById(String id) async {
    return gardens.firstWhere((garden) => garden.id == id);
  }

  // Save gardens to SharedPreferences
  Future<void> _saveGardensToSharedPreferences(List<Garden> gardens) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> gardenJsonList =
        gardens.map((garden) => jsonEncode(garden.toJson())).toList();
    await prefs.setStringList('gardens', gardenJsonList);

    if (kDebugMode) {
      print("Gardens saved to SharedPreferences:");
      gardenJsonList.forEach(print);
    }
  }

  // Load gardens from SharedPreferences
  Future<List<Garden>> loadGardensFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? gardenJsonList = prefs.getStringList('gardens');
    if (gardenJsonList != null) {
      return gardenJsonList
          .map((gardenJson) => Garden.fromJson(jsonDecode(gardenJson)))
          .toList();
    }
    return [];
  }
}
