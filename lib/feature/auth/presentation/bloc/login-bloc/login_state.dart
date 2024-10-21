part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginRespEntity data;

  const LoginSuccess({required this.data});

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class LoginFailed extends LoginState {
  final String? msg;

  const LoginFailed({required this.msg});

  @override
  // TODO: implement props
  List<Object> get props => [msg!];
}
