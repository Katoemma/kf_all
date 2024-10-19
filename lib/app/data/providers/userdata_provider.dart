//class to handle user data from airtable and store in memory
import 'dart:convert';

import 'package:airtable_crud/airtable_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:kijani_branch/app/data/models/farmer.dart';
import 'package:kijani_branch/app/data/models/garden.dart';
import 'package:kijani_branch/app/data/models/group.dart';
import 'package:kijani_branch/app/data/models/parish_model.dart';
import 'package:kijani_branch/global/services/airtable_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider {
  final List<Parish> parishes = [];

  // Fetch the data for each parish and store it in memory
  Future<void> fetchParishes(List<Parish> parishList) async {
    for (var parish in parishList) {
      parishes.add(parish); // Add the parish to the list

      // For each parish, fetch its groups
      List<Group>? groups = await _fetchGroupsForParish(parish);
      parish.groups.addAll(groups!); // Add the fetched groups to the parish

      if (kDebugMode) {
        print('i want to fetch groups now');
      }

      // For each group, fetch its farmers
      for (var group in parish.groups) {
        List<Farmer>? farmers = await _fetchFarmersForGroup(group);
        group.farmers.addAll(farmers!); // Add the fetched farmers to the group

        // For each farmer, fetch their gardens
        for (var farmer in group.farmers) {
          List<Garden>? gardens = await _fetchGardensForFarmer(farmer);
          farmer.gardens
              .addAll(gardens!); // Add the fetched gardens to the farmer
        }
      }
    }

    //save the parishes data to shared preferences
    await _saveParishesToSharedPreferences(parishes);
  }

  Future<void> _saveParishesToSharedPreferences(List<Parish> parishes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> parishJsonList =
        parishes.map((parish) => jsonEncode(parish.toJson())).toList();
    print("Saving the following parishes:");
    parishJsonList.forEach(print);
    await prefs.setStringList('parishes', parishJsonList);
  }

  Future<List<Group>?> _fetchGroupsForParish(Parish parish) async {
    if (kDebugMode) {
      print('fetching groups for parish ${parish.parishId}');
    }
    try {
      var response = await nurseryBase.fetchRecordsWithFilter(
          'Group Allocation',
          'AND({Parish ID} = "${parish.parishId}",  {Season Status}= "Current")');
      return response.map((record) => Group.fromJson(record.fields)).toList();
    } on AirtableException catch (e) {
      if (kDebugMode) {
        print(e.message + e.details!);
      }
    } catch (e) {
      if (kDebugMode) {
        print("ERRORR:${e.toString()}");
      }
    }
    return null;
  }

  Future<List<Farmer>?> _fetchFarmersForGroup(Group group) async {
    if (kDebugMode) {
      print('fetching farmers for group${group.name}');
    }
    try {
      var response = await gardenBase.fetchRecordsWithFilter(
          'Farmers', 'AND({Registered From} = "${group.id}")');
      if (kDebugMode) {
        print('done fetching farmers');
      }
      return response.map((record) => Farmer.fromJson(record.fields)).toList();
    } on AirtableException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      if (kDebugMode) {
        print(e.details);
      }
    } catch (e) {
      if (kDebugMode) {
        print('ERROR FETCHING FARMERS:${e.toString()}');
      }
    }
    return null;
  }

  Future<List<Garden>?> _fetchGardensForFarmer(Farmer farmer) async {
    if (kDebugMode) {
      print('fetching gardens for farmer:${farmer.name}');
    }
    try {
      var response = await currentGardenBase.fetchRecordsWithFilter(
          'Gardens', 'AND({FarmerID} = "${farmer.id}-${farmer.name}")');
      if (kDebugMode) {
        print('done fetching gardens');
      }
      return response.map((record) => Garden.fromJson(record.fields)).toList();
    } on AirtableException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      if (kDebugMode) {
        print(e.details);
      }
    } catch (e) {
      if (kDebugMode) {
        print('FETCH GARDEN ERROR ${e.toString()}');
      }
    }
    return null;
  }
}
