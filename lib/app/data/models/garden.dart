class Garden {
  final String id;
  final bool isBoundary;
  final String center;
  final String polygon;
  final String initialPlantingDate;
  final int received;
  final int lost;
  final int planted;
  final int surviving;
  final int replaced;
  final List<String> species;

  Garden({
    required this.id,
    required this.isBoundary,
    required this.center,
    required this.polygon,
    required this.initialPlantingDate,
    required this.received,
    required this.lost,
    required this.planted,
    required this.surviving,
    required this.replaced,
    required this.species,
  });

  factory Garden.fromJson(Map<String, dynamic> json) {
    return Garden(
      id: json['ID'] ?? 'No ID',
      isBoundary: _getBoolFromJson(json, 'Boundary Planting'),
      center: _getStringFromJson(json, 'Center Point'),
      polygon: _getStringFromJson(json, 'Polygon GeoJSON'),
      initialPlantingDate: _getStringFromJson(json, 'Initial planting date'),
      received: _getIntFromJson(json, 'Recieved Seedlings'),
      lost: _getIntFromJson(json, 'Lost Seedlings'),
      planted: _getIntFromJson(json, 'Planted Trees'),
      surviving: _getIntFromJson(json, 'Surviving Trees'),
      replaced: _getIntFromJson(json, 'Replaced Trees'),
      species: _getListFromString(json, 'SpeciesIDS'),
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

  // Helper method to safely extract integer values
  static int _getIntFromJson(Map<String, dynamic> json, String key) {
    var value = json[key];
    if (value != null) {
      if (value is int) {
        return value;
      } else if (value is String) {
        return int.tryParse(value) ?? 0;
      } else if (value is List && value.isNotEmpty) {
        return int.tryParse(value[0].toString()) ?? 0;
      }
    }
    return 0;
  }

  // Helper method to extract a list from a comma-separated string
  static List<String> _getListFromString(
      Map<String, dynamic> json, String key) {
    var value = json[key];
    if (value != null && value is String) {
      return value.split(',').map((s) => s.trim()).toList();
    }
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isBoundary': isBoundary,
      'center': center,
      'polygon': polygon,
      'initialPlantingDate': initialPlantingDate,
      'received': received,
      'lost': lost,
      'planted': planted,
      'surviving': surviving,
      'replaced': replaced,
      'species': species,
    };
  }
}
