import 'package:contacts/model/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String columnId = 'id';
final String columnContactName = 'contactName';
final String columnNumber = 'number';
final String columnContactURL = 'contactURL';
final String tableContacts = 'contacts';

class ContactProvider {
  late Database db;

  static final ContactProvider instance = ContactProvider._internal();

  factory ContactProvider() {
    return instance;
  }

  ContactProvider._internal();

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'books.db'),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute('''
create table $tableContacts ( 
  $columnId integer primary key autoincrement, 
  $columnContactName text not null,
  $columnNumber text not null,
  $columnContactURL text not null
  )
''');
        });
  }

  Future<Contact> insert(Contact contact) async {
    contact.id = await db.insert(tableContacts, contact.toMap());
    return contact;
  }

  Future<List<Contact>> getBooks() async {
    List<Map<String, dynamic>> contactMaps = await db.query(tableContacts);
    if (contactMaps.isEmpty) {
      return [];
    } else {
      List<Contact> contact = [];
      for (var element in contactMaps) {
        contact.add(Contact.fromMap(element));
      }
      return contact;
    }
  }

  Future<int> delete(int id) async {
    return await db.delete(tableContacts, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Contact contact) async {
    return await db.update(tableContacts, contact.toMap(),
        where: '$columnId = ?', whereArgs: [contact.id]);
  }


  Future close() async => db.close();

}
