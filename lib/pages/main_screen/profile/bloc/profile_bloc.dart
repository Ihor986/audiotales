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
      cangeProfileService.phone = event.user.phone;
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

    on<SaveEditingWithPhoneEvent>((event, emit) async {
      cangeProfileService.sendCodeToFirebaseChangeNumber();
      if (cangeProfileService.e == null) {
        LocalUser _user = event.user;
        _user.changeUserFields(
          nPhoto: cangeProfileService.photo,
          nName: cangeProfileService.nameController,
          nPhotoUrl: cangeProfileService.photoUrl,
          nPhone: cangeProfileService.phone,
        );
        DataBase.instance.saveUser(_user);
        cangeProfileService.dispouse();
      }

      emit(ProfileInitialState());
    });

    on<ChangeNameEvent>((event, emit) {
      cangeProfileService.nameController = event.newName;
      // emit(ProfileInitialState());
    });

    on<ChangePhoneEvent>((event, emit) {
      cangeProfileService.phone = event.newPhone;
      if (cangeProfileService.phone != event.user.phone) {
        cangeProfileService.isChangeNumber = true;
      }
      // emit(ProfileInitialState());
    });

    on<SaveChangedPhoneEvent>((event, emit) {
      cangeProfileService.changePhoneNumber();
      cangeProfileService.isChangeNumber = true;
      // cangeProfileService.phone = event.newPhone;
      emit(ProfileInitialState());
    });

    on<ChangeCodeEvent>((event, emit) {
      cangeProfileService.smsCode = event.code;
      // emit(ProfileInitialState());
    });
  }
}
