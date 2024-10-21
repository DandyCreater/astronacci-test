part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final List<DataUserEntity> data;
  final bool isLoadingMore;

  const UserSuccess({required this.data, required this.isLoadingMore});

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class UserFailed extends UserState {
  final String? msg;

  const UserFailed({required this.msg});

  @override
  // TODO: implement props
  List<Object> get props => [msg!];
}
