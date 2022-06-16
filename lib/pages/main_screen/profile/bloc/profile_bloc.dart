import 'package:audiotales/data_base/data_base.dart';
import 'package:audiotales/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../services/change_profile_servise.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileInitialState> {
  final CangeProfileService cangeProfileService = CangeProfileService();
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileEditingEvent>((event, emit) {
      cangeProfileService.dispouse();
      cangeProfileService.readOnly = false;
      cangeProfileService.nameController = event.newName;
      emit(ProfileInitialState());
    });

    on<SaveEditingEvent>((event, emit) {
      // User? userFB = FirebaseAuth.instance.currentUser;
      // userFB.updatePhoneNumber(phoneCredential);
      LocalUser _user = event.user;
      _user.changeUserFields(
        nPhoto: cangeProfileService.photo,
        nName: cangeProfileService.nameController,
        nPhotoUrl: cangeProfileService.photoUrl,
      );
      DataBase.instance.saveUser(_user);
      cangeProfileService.dispouse();
      emit(ProfileInitialState());
    });

    on<ChangeNameEvent>((event, emit) {
      cangeProfileService.nameController = event.newName;
      // emit(ProfileInitialState());
    });

    on<ChangePhoneEvent>((event, emit) {
      cangeProfileService.phone = event.newPhone;
      // emit(ProfileInitialState());
    });
  }
}
