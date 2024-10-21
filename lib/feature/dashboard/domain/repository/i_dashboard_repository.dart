import 'package:dartz/dartz.dart';

import '../entity/user_resp_entity.dart';

abstract class IDashboardRepository {
  Future<Either<String, UserRespEntity>> getUserList(int page);
}
