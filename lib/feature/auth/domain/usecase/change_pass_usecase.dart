import 'package:dartz/dartz.dart';

import '../repository/i_auth_repository.dart';

class ChangePassUseCase {
  final IAuthRepository repository;

  ChangePassUseCase(this.repository);

  Future<Either<String, bool>> call(
          String email, String oldPassword, String newPassword) =>
      repository.changePassword(email, oldPassword, newPassword);
}
