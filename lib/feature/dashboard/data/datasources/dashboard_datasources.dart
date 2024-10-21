import 'package:astronacci/core/services/services.dart';
import 'package:astronacci/feature/dashboard/data/datasources/i_dashboard_datasources.dart';
import 'package:astronacci/feature/dashboard/data/model/user_resp_model.dart';
import 'package:flutter/material.dart';

class DashboardDataSources implements IDashboardDataSources {
  Services services = Services();
  @override
  Future<UserRespModel> getListUser(int page) async {
    try {
      final result = await services.request(
          methods: RequestMethods.get,
          params: "",
          tableName: "users?page=$page");
      debugPrint("data" + result.toString());
      return UserRespModel.fromJson(result);
    } catch (e) {
      debugPrint("Get List User Error");
      throw e;
    }
  }
}
