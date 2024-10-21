import '../model/user_resp_model.dart';

abstract class IDashboardDataSources {
  Future<UserRespModel> getListUser(int page);
}
