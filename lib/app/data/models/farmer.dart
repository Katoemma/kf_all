import 'package:kijani_branch/app/data/models/garden.dart';

class Farmer {
  final String id;
  final String name;
  final String gender;
  final String phone;
  final bool onBoarded;
  final bool contract;
  final List<Garden> gardens;

  Farmer({
    required this.id,
    required this.name,
    required this.gender,
    required this.phone,
    required this.onBoarded,
    required this.contract,
    required this.gardens,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      id: json['ID'] ?? 'No ID',
      name: _getName(json),
      gender: _getStringFromJson(json, 'Gender'),
      phone: _getStringFromJson(json, 'Phone'),
      onBoarded: _getBoolFromJson(json, 'Onboarded'),
      contract: _getBoolFromJson(json, 'Contract'),
      gardens: [], // Start with an empty list, will populate later
    );
  }

  // Helper method to safely construct name
  static String _getName(Map<String, dynamic> json) {
    var firstName = json['First Name'] ?? '';
    var lastName = json['Last Name'] ?? '';
    return (firstName + ' ' + lastName).trim();
  }

  // Helper method to safely extract string values
  static String _getStringFromJson(Map<String, dynamic> json, String key) {
    var value = json[key];
    if (value != null && value is String) {
      return value;
    }
    return 'Not available';
  }

  // Helper method to safely extract boolean values
  static bool _getBoolFromJson(Map<String, dynamic> json, String key) {
    var value = json[key];
    if (value != null) {
      if (value is bool) {
        return value;
      } else if (value is String) {
        return value.toLowerCase() == 'yes' || value.toLowerCase() == 'true';
      }
    }
    return false;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'phone': phone,
      'onBoarded': onBoarded,
      'contract': contract,
      'gardens': gardens,
    };
  }
}
