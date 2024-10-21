part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailed extends RegisterState {
  final String? msg;

  const RegisterFailed({required this.msg});

  @override
  // TODO: implement props
  List<Object> get props => [msg!];
}
