import 'package:contacts/database/database.dart';

class Contact {
  int? id;
  String? name;
  String? number;
  String? url;

  Contact({
    this.id,
    required this.name,
    required this.number,
    required this.url,
  });

  Contact.fromMap(Map<String, dynamic> map) {
    if (map[columnId] != null) id = map[columnId];
    name = map[columnContactName];
    number = map[columnNumber];
    url = map[columnContactURL];
  }

  Map <String , dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (id != null) map[columnId] = id;
    map[columnContactName] = name;
    map[columnNumber] = number;
    map[columnContactURL] = url;
    return map;
  }
}
