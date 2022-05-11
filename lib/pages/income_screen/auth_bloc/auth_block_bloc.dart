import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data_base/local_data_base.dart';
import '../../../models/user.dart';

part 'auth_block_event.dart';
part 'auth_block_state.dart';

class AuthBlockBloc extends Bloc<AuthBlockEvent, AuthBlockState> {
  // final LocalUser user;
  AuthBlockBloc() : super(AuthBlockInitial()) {
    on<ContinueButtonEvent>((event, emit) async {
      emit(AuthBlockInitial());
    });
    on<ContinueButtonPhoneEvent>((event, emit) async {
      emit(AuthBlockPhoneInitial());
    });
    on<ContinueButtonCodeEvent>((event, emit) async {
      event.user.phone = event.phone;
      event.user.isUserRegistered = true;
      LocalDB.instance.saveUser(event.user);
    });
  }
}
