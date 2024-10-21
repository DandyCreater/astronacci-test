part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserData extends ProfileEvent {
  final LoginRespEntity data;

  const FetchUserData(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class UpdateUserData extends ProfileEvent {
  final EditProfileParameterPost params;

  const UpdateUserData(this.params);
  @override
  // TODO: implement props
  List<Object> get props => [params];
}
