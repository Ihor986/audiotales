import 'package:audiotales/models/tales_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data_base/data/local_data_base.dart';
import '../../../data_base/data_base.dart';
import '../../../models/user.dart';
import '../../../repositorys/auth.dart';

part 'auth_block_event.dart';
part 'auth_block_state.dart';

class AuthBlockBloc extends Bloc<AuthBlockEvent, AuthBlockState> {
  AuthBlockBloc() : super(AuthBlockInitial()) {
    on<ContinueButtonEvent>((event, emit) async {
      emit(AuthBlockInitial());
    });
    on<ContinueButtonPhoneEvent>((event, emit) async {
      emit(AuthBlockPhoneInitial());
    });
    on<ContinueButtonCodeEvent>((event, emit) async {
      User? user = FirebaseAuth.instance.currentUser;
      if (event.auth.isNewUser == false) {
        event.user.updateUser(newUser: DataBase.instance.getUser());
        // event.talesList
        //     .updateTalesList(newTalesList: DataBase.instance.getAudioTales());
        DataBase.instance.saveUser(Future.value(event.user));
        DataBase.instance.saveAudioTales(Future.value(event.talesList));
      } else {
        event.user.phone = event.auth.phoneNumberForVerification;
        event.user.isUserRegistered = true;
        event.user.id = user?.uid;
        DataBase.instance.saveUser(Future.value(event.user));
        DataBase.instance.saveAudioTales(Future.value(event.talesList));
      }
    });
  }
}
