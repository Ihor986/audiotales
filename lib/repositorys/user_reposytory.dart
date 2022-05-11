import 'package:firebase_auth/firebase_auth.dart';

import '../data_base/local_data_base.dart';
import '../models/user.dart';

class UserRepository {
  LocalUser localUser = LocalDB.instance.getUser().id != null
      ? LocalDB.instance.getUser()
      : LocalUser(
          isNewUser: false, id: '${DateTime.now().microsecondsSinceEpoch}');
  User? user = FirebaseAuth.instance.currentUser;
  // FirebaseFirestore.instance.collection('userData').add()
}
