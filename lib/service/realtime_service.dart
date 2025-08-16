import 'package:firebase_database/firebase_database.dart';

class RealtimeService{
  final streamRef = FirebaseDatabase.instance.ref('users');

  Future<void> saveData() async {
    await streamRef.child('111111').set({
      'from': 'Tokyo',
      'sports': 'soccer',
      'food': 'hamburger',
    });
  }

}