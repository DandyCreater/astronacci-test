part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}

class ChangePasswordFailed extends ChangePasswordState {
  final String? msg;

  const ChangePasswordFailed(this.msg);

  @override
  // TODO: implement props
  List<Object> get props => [msg!];
}
