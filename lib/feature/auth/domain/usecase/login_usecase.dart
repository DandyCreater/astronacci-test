import 'package:astronacci/feature/auth/domain/repository/i_auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../entity/login_resp_entity.dart';

class LoginUseCase {
  final IAuthRepository repository;

  const LoginUseCase(this.repository);

  Future<Either<String, LoginRespEntity>> call(String email, String password) =>
      repository.login(email, password);
}
