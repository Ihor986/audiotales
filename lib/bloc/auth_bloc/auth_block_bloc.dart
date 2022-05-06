import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

part 'auth_block_event.dart';
part 'auth_block_state.dart';

class AuthBlockBloc extends Bloc<AuthBlockEvent, AuthBlockState> {
  // final AuthReposytory authReposytory;
  final LocalUser user;
  AuthBlockBloc(this.user) : super(AuthBlockInitial()) {
    on<ContinueButtonEvent>((event, emit) async {
      emit(AuthBlockInitial());
    });
    on<ContinueButtonPhoneEvent>((event, emit) async {
      emit(AuthBlockPhoneInitial());
    });
  }
}
// репозиторий провайдер