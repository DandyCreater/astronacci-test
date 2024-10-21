import 'package:astronacci/feature/dashboard/data/datasources/i_dashboard_datasources.dart';
import 'package:astronacci/feature/dashboard/data/model/user_resp_model.dart';
import 'package:astronacci/feature/dashboard/domain/entity/user_resp_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../domain/repository/i_dashboard_repository.dart';

class DashboardRepository extends IDashboardRepository {
  final IDashboardDataSources dashboardDataSources;

  DashboardRepository(this.dashboardDataSources);
  Future<Either<String, UserRespEntity>> getUserList(int page) async {
    try {
      UserRespModel result = await dashboardDataSources.getListUser(page);
      if (result.data.isNotEmpty) {
        return right(result.toEntity());
      } else {
        return left("Something Wrong Error");
      }
    } catch (e) {
      debugPrint("Error Repository get User List $e");
      return const Left("Something Wrong!");
    }
  }
}
