import 'package:firebase_database/firebase_database.dart';

class Users {
  String? fullName;
  String? email;
  String? phone;
  String? id;

  Users({
    this.email,
    this.fullName,
    this.phone,
    this.id,
  });

  Users.fromSnapshot(DatabaseEvent databaseEvent) {
    final data = databaseEvent.snapshot.value as Map;
    id = databaseEvent.snapshot.key;
    phone = data['phone'];
    email = data['email'];
    fullName = data['name'];
  }
}
