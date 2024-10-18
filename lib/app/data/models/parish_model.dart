import 'package:kijani_branch/app/data/models/group.dart';

class Parish {
  final String id;
  final String parishId;
  final String name;
  final List<Group> groups;
  final String pcID;
  final String pcName;
  final String pcEmail;
  final String status;

  Parish({
    required this.id,
    required this.parishId,
    required this.name,
    required this.groups,
    required this.pcID,
    required this.pcName,
    required this.pcEmail,
    required this.status,
  });

  factory Parish.fromAirtable(Map<String, dynamic> json) {
    return Parish(
      id: json['ID'],
      parishId: json['Parish'],
      name: json['Parish Name'],
      groups: [],
      pcID: json['PC'],
      pcName: json['PC-Name'],
      pcEmail: json['PC-Email'],
      status: json['Status'],
    );
  }
}
