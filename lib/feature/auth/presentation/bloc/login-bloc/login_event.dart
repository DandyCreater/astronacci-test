part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class StartLogin extends LoginEvent {
  final String? email;
  final String? password;

  const StartLogin({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object> get props => [email!, password!];
}
