import 'package:astronacci/feature/dashboard/domain/entity/user_resp_entity.dart';
import 'package:dartz/dartz.dart';

import '../repository/i_dashboard_repository.dart';

class DashboardUseCase {
  IDashboardRepository repository;

  DashboardUseCase(this.repository);
  Future<Either<String, UserRespEntity>> call(int page) async {
    return repository.getUserList(page);
  }
}
