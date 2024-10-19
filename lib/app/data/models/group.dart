import 'package:kijani_branch/app/data/models/farmer.dart';

class Group {
  final String id;
  final String name;
  final String coordinates;
  final int potted;
  final int pricked;
  final int sorted;
  final int distributed;
  final String lastVisit;
  final int numVisits;
  final List<Farmer> farmers;

  Group({
    required this.id,
    required this.name,
    required this.coordinates,
    required this.potted,
    required this.pricked,
    required this.sorted,
    required this.distributed,
    required this.lastVisit,
    required this.numVisits,
    required this.farmers,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['ID'] ?? 'No id',
      name: _getStringFromJson(json, 'Group Name'),
      coordinates: _getStringFromJson(json, 'Parish Name'),
      potted: _getIntFromJson(json, 'Total Potted 2024'),
      pricked: _getIntFromJson(json, 'Total Pricked 2024'),
      sorted: _getIntFromJson(json, 'Total Sorted 2024'),
      distributed: _getIntFromJson(json, 'Total Distributed 2024'),
      lastVisit: _getStringFromJson(json, 'Last Visted 2024'),
      numVisits: _getIntFromJson(json, 'Num_Visits 2024'),
      farmers: [],
    );
  }

  // Helper method to safely extract string values
  static String _getStringFromJson(Map<String, dynamic> json, String key) {
    var value = json[key];
    if (value != null) {
      if (value is List && value.isNotEmpty) {
        return value[0].toString();
      } else if (value is String) {
        return value;
      }
    }
    return 'Not available';
  }

  // Helper method to safely extract integer values
  static int _getIntFromJson(Map<String, dynamic> json, String key) {
    var value = json[key];
    if (value != null) {
      if (value is List && value.isNotEmpty) {
        return int.tryParse(value[0].toString()) ?? 0;
      } else if (value is int) {
        return value;
      }
    }
    return 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'coordinates': coordinates,
      'potted': potted,
      'pricked': pricked,
      'sorted': sorted,
      'distributed': distributed,
      'lastVisit': lastVisit,
      'numVisits': numVisits,
      'farmers': farmers
          .map((farmer) => farmer.toJson())
          .toList(), // Correctly serialize nested objects
    };
  }
}
