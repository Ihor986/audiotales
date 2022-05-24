import 'package:audiotales/data_base/data_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data_base/data/local_data_base.dart';
import '../models/user.dart';

class UserRepository {
  LocalUser getLocalUser() {
    return LocalDB.instance.getUser().isNewUser == null
        ? LocalUser(isNewUser: false)
        : DataBase.instance.getUser();
  }

  User? getAuthUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
