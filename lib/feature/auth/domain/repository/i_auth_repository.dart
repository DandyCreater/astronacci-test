import 'package:dartz/dartz.dart';

import '../../data/model/login_resp_model.dart';
import '../entity/login_resp_entity.dart';

abstract class IAuthRepository {
  Future<Either<String, bool>> createUser(RegisterParameterPost param);
  Future<Either<String, LoginRespEntity>> login(String email, String password);
  Future<Either<String, bool>> resetPassword(String email);
  Future<Either<String, bool>> changePassword(
      String email, String oldPassword, String newPassword);
}
