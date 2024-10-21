import 'package:astronacci/feature/auth/data/model/login_resp_model.dart';

import '../model/edit_profile_resp_model.dart';

abstract class IProfileDataSources {
  Future<LoginRespModel> updateProfile(EditProfileParameterPost params);
}
