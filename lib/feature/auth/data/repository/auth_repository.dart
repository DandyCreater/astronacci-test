import 'package:astronacci/feature/auth/data/datasources/i_auth_datasources.dart';
import 'package:astronacci/feature/auth/data/model/login_resp_model.dart';
import 'package:astronacci/feature/auth/data/model/regist_resp_model.dart';
import 'package:astronacci/feature/auth/domain/entity/login_resp_entity.dart';
import 'package:astronacci/feature/auth/domain/repository/i_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class AuthRepository extends IAuthRepository {
  final IAuthDataSources dataSources;

  AuthRepository({required this.dataSources});

  @override
  Future<Either<String, bool>> createUser(RegisterParameterPost param) async {
    try {
      RegistRespModel result = await dataSources.createUser(param);
      if (result.isSuccess == true) {
        return right(true);
      } else {
        return left(result.msg ?? "");
      }
    } catch (e) {
      return const Left("Something Wrong!");
    }
  }

  @override
  Future<Either<String, LoginRespEntity>> login(
      String email, String password) async {
    try {
      LoginRespModel result = await dataSources.login(email, password);

      if (result.msg == null || result.msg!.isEmpty) {
        return right(result.toEntity());
      } else {
        debugPrint("result name => ${result.msg}");
        return left(result.msg ?? "");
      }
    } catch (e) {
      debugPrint("Something Wrong! $e");
      return const Left("Something Wrong!");
    }
  }

  @override
  Future<Either<String, bool>> resetPassword(String email) async {
    try {
      bool result = await dataSources.resetPassword(email);
      if (result) {
        return right(result);
      } else {
        return left("Something Wrong!");
      }
    } catch (e) {
      debugPrint("Something Wrong! $e");
      return const Left("Something Wrong!");
    }
  }

  @override
  Future<Either<String, bool>> changePassword(
      String email, String oldPassword, String newPassword) async {
    try {
      LoginRespModel result =
          await dataSources.changePassword(email, oldPassword, newPassword);

      if (result.msg == null) {
        return right(true);
      } else {
        return left(result.msg ?? "");
      }
    } catch (e) {
      debugPrint("Something Wrong! $e");
      return const Left("Something Wrong!");
    }
  }
}
