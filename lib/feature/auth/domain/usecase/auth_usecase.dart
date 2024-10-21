import 'package:astronacci/feature/auth/domain/entity/login_resp_entity.dart';
import 'package:astronacci/feature/auth/domain/repository/i_auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../data/model/login_resp_model.dart';

class AuthUseCase {
  final IAuthRepository repository;

  const AuthUseCase(this.repository);

  Future<Either<String, bool>> call(RegisterParameterPost param) =>
      repository.createUser(param);
}
