part of 'update_profile_bloc.dart';

class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

class StartEditData extends UpdateProfileEvent {
  final EditProfileParameterPost params;

  const StartEditData(this.params);

  @override
  // TODO: implement props
  List<Object> get props => [params];
}
