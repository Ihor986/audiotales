part of 'auth_block_bloc.dart';

enum Status {
  phone,
  code,
}

class AuthBlockState {
  AuthBlockState({this.status = Status.phone});
  Status status;
}
