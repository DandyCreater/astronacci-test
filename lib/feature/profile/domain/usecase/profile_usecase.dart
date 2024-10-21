import 'package:astronacci/feature/profile/domain/repository/i_profile_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../auth/domain/entity/login_resp_entity.dart';
import '../../data/model/edit_profile_resp_model.dart';

class ProfileUseCase {
  final IProfileRepository repository;

  ProfileUseCase(this.repository);

  Future<Either<String, LoginRespEntity>> call(
          EditProfileParameterPost params) =>
      repository.updateProfile(params);
}
