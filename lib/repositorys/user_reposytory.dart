import 'package:firebase_auth/firebase_auth.dart';

import '../data_base/local_data_base.dart';
import '../models/user.dart';

class UserRepository {
  LocalUser localUser = LocalDB.instance.getUser();
  User? user = FirebaseAuth.instance.currentUser;
  // FirebaseFirestore.instance.collection('userData').add()
}
