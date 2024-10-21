import 'package:dartz/dartz.dart';

import '../../../auth/domain/entity/login_resp_entity.dart';
import '../../data/model/edit_profile_resp_model.dart';

abstract class IProfileRepository {
  Future<Either<String, LoginRespEntity>> updateProfile(
      EditProfileParameterPost params);
}
