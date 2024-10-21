import 'package:astronacci/feature/auth/domain/entity/login_resp_entity.dart';
import 'package:astronacci/feature/profile/domain/usecase/profile_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/edit_profile_resp_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchUserData>((event, emit) async {
      emit(ProfileSuccess(event.data));
    });
  }
}
