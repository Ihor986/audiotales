import 'package:firebase_auth/firebase_auth.dart';

import '../models/tales_list.dart';
import '../models/user.dart';
import 'data/firestore_data_base.dart';
import 'data/local_data_base.dart';

class DataBase {
  const DataBase._();

  static const DataBase instance = DataBase._();

  LocalUser getUser() {
    final LocalUser _user = LocalDB.instance.getUser();
    String? id = FirebaseAuth.instance.currentUser?.uid;
    LocalDB.instance.saveUser(
        FirestoreDB.instance.getUserFromFirestore(user: _user, id: id));
    return _user.isNewUser == null ? LocalUser(isNewUser: false) : _user;
  }

  TalesList getAudioTales() {
    String? id = FirebaseAuth.instance.currentUser?.uid;
    LocalDB.instance.saveAudioTales(
      FirestoreDB.instance.getAudioTales(
        id: id,
        list: LocalDB.instance.getAudioTales(),
      ),
    );
    return LocalDB.instance.getAudioTales();
  }
}
