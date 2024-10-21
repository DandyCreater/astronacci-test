import '../model/login_resp_model.dart';
import '../model/regist_resp_model.dart';

abstract class IAuthDataSources {
  Future<RegistRespModel> createUser(RegisterParameterPost param);
  Future<LoginRespModel> login(String email, String password);
  Future<bool> resetPassword(String email);
  Future<LoginRespModel> changePassword(
      String email, String oldPassword, String newPassword);
}
