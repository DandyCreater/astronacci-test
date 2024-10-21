import 'package:astronacci/feature/auth/domain/entity/login_resp_entity.dart';
import 'package:dartz/dartz.dart';

import 'package:astronacci/feature/profile/data/model/edit_profile_resp_model.dart';

import 'package:astronacci/feature/auth/data/model/login_resp_model.dart';
import 'package:flutter/material.dart';

import '../../domain/repository/i_profile_repository.dart';
import '../datasource/i_profile_datasources.dart';

class ProfileRepository extends IProfileRepository {
  final IProfileDataSources dataSources;

  ProfileRepository(this.dataSources);

  @override
  Future<Either<String, LoginRespEntity>> updateProfile(
      EditProfileParameterPost params) async {
    try {
      LoginRespModel result = await dataSources.updateProfile(params);
      if (result.msg == null || result.msg!.isEmpty) {
        return right(result.toEntity());
      } else {
        return left(result.msg ?? "");
      }
    } catch (e) {
      debugPrint("Update Profile Error $e");
      return const Left("Update Profile Error");
    }
  }
}
