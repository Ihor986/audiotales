import 'package:audiotales/models/user.dart';
import 'package:bloc/bloc.dart';
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
      cangeProfileService.phone =
          event.user.currentUser?.phoneNumber ?? '0000000000000'.substring(3);
      cangeProfileService.nameController = event.newName;
      emit(ProfileInitialState());
    });

    on<SaveEditingEvent>((event, emit) async {
      emit(ProfileInitialState(isProgress: true));
      LocalUser _user = event.user;
      _user.changeUserFields(
        nName: cangeProfileService.nameController,
      );
      await cangeProfileService.saveImage(_user);
      cangeProfileService.dispouse();
      emit(ProfileInitialState());
    });

    on<SaveEditingWithPhoneEvent>((event, emit) async {
      emit(ProfileInitialState(isProgress: true));
      cangeProfileService.sendCodeToFirebaseChangeNumber();
      if (cangeProfileService.e == null) {
        LocalUser _user = event.user;
        _user.changeUserFields(
          nName: cangeProfileService.nameController,
          // nPhone: cangeProfileService.phone,
        );
        await cangeProfileService.saveImage(_user);
        cangeProfileService.dispouse();
      }

      emit(ProfileInitialState());
    });

    on<ChangeNameEvent>((event, emit) {
      cangeProfileService.nameController = event.newName;
    });

    on<ChangePhoneEvent>((event, emit) {
      cangeProfileService.phone = event.newPhone;
      // print(cangeProfileService.phone);
      // print(event.user.phone);
      if (cangeProfileService.phone != event.user.currentUser?.phoneNumber) {
        cangeProfileService.isChangeNumber = true;
      }
    });

    on<SaveChangedPhoneEvent>((event, emit) {
      cangeProfileService.changePhoneNumber();
      cangeProfileService.isChangeNumber = true;
      emit(ProfileInitialState());
    });

    on<ChangeCodeEvent>((event, emit) {
      cangeProfileService.smsCode = event.code;
    });
  }
}
