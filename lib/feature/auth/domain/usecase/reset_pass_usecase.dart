import 'package:dartz/dartz.dart';

import '../repository/i_auth_repository.dart';

class ResetPassUseCase {
  final IAuthRepository repository;

  const ResetPassUseCase(this.repository);

  Future<Either<String, bool>> call(String email) =>
      repository.resetPassword(email);
}
