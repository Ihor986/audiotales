import 'package:audiotales/models/tales_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../data_base/data_base.dart';
import '../../../models/user.dart';
import '../../../repositorys/auth.dart';

part 'auth_block_event.dart';
part 'auth_block_state.dart';

class AuthBlockBloc extends Bloc<AuthBlockEvent, AuthBlockState> {
  AuthBlockBloc() : super(AuthBlockState()) {
    on<ContinueButtonEvent>((event, emit) async {
      emit(AuthBlockState());
    });
    on<ContinueButtonPhoneEvent>((event, emit) async {
      emit(AuthBlockState(status: Status.code));
    });
    on<ContinueButtonCodeEvent>((event, emit) async {
      state.status = Status.phone;

      User? user = FirebaseAuth.instance.currentUser;
      if (event.auth.isNewUser == false) {
        event.user.updateUser(newUser: DataBase.instance.getUser());
        // event.talesList
        //     .updateTalesList(newTalesList: DataBase.instance.getAudioTales());
        DataBase.instance.saveUser(event.user);
        DataBase.instance.saveAudioTales(event.talesList);
      } else {
        event.user.phone = event.auth.phoneNumberForVerification;
        event.user.isUserRegistered = true;
        event.user.id = user?.uid;
        DataBase.instance.saveUser(event.user);
        DataBase.instance.saveAudioTales(event.talesList);
      }
    });
  }
}
