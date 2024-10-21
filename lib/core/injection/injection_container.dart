import 'package:astronacci/feature/auth/data/datasources/auth_datasources.dart';
import 'package:astronacci/feature/auth/data/datasources/i_auth_datasources.dart';
import 'package:astronacci/feature/auth/data/repository/auth_repository.dart';
import 'package:astronacci/feature/auth/domain/repository/i_auth_repository.dart';
import 'package:astronacci/feature/auth/domain/usecase/auth_usecase.dart';
import 'package:astronacci/feature/auth/domain/usecase/change_pass_usecase.dart';
import 'package:astronacci/feature/auth/domain/usecase/login_usecase.dart';
import 'package:astronacci/feature/auth/domain/usecase/reset_pass_usecase.dart';
import 'package:astronacci/feature/auth/presentation/bloc/login-bloc/login_bloc.dart';
import 'package:astronacci/feature/auth/presentation/bloc/register-bloc/register_bloc.dart';
import 'package:astronacci/feature/auth/presentation/bloc/reset-password-bloc/reset_password_bloc.dart';
import 'package:astronacci/feature/auth/presentation/cubit/obsecure-cubit/obsecure_cubit.dart';
import 'package:astronacci/feature/auth/presentation/cubit/register-cubit/register_cubit.dart';
import 'package:astronacci/feature/dashboard/data/datasources/dashboard_datasources.dart';
import 'package:astronacci/feature/dashboard/data/datasources/i_dashboard_datasources.dart';
import 'package:astronacci/feature/dashboard/data/repository/dashboard_repository.dart';
import 'package:astronacci/feature/dashboard/domain/repository/i_dashboard_repository.dart';
import 'package:astronacci/feature/dashboard/domain/usecase/dashboard_usecase.dart';
import 'package:astronacci/feature/dashboard/presentation/bloc/user-bloc/user_bloc.dart';
import 'package:astronacci/feature/dashboard/presentation/cubit/count-cubit/count_cubit.dart';
import 'package:astronacci/feature/profile/data/datasource/i_profile_datasources.dart';
import 'package:astronacci/feature/profile/data/datasource/profile_datasources.dart';
import 'package:astronacci/feature/profile/data/repository/profile_repository.dart';
import 'package:astronacci/feature/profile/domain/usecase/profile_usecase.dart';
import 'package:astronacci/feature/profile/presentation/bloc/change-password-bloc/change_password_bloc.dart';
import 'package:astronacci/feature/profile/presentation/bloc/profile-bloc/profile_bloc.dart';
import 'package:astronacci/feature/profile/presentation/bloc/update-profile-bloc/update_profile_bloc.dart';
import 'package:astronacci/feature/profile/presentation/cubit/edit-profile-cubit/edit_profile_cubit.dart';
import 'package:astronacci/feature/profile/presentation/cubit/new-pass-cubit/new_pass_cubit.dart';
import 'package:astronacci/feature/profile/presentation/cubit/old-pass-cubit/old_pass_cubit.dart';
import 'package:astronacci/feature/profile/presentation/cubit/validate-pass-cubit/validate_pass_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../feature/profile/domain/repository/i_profile_repository.dart';
import '../../feature/profile/presentation/cubit/image-cubit/image_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory(() => UserBloc(sl()));
  sl.registerFactory(() => RegisterBloc(sl()));
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => ProfileBloc());
  sl.registerFactory(() => UpdateProfileBloc(sl()));
  sl.registerFactory(() => ResetPasswordBloc(sl()));
  sl.registerFactory(() => ChangePasswordBloc(sl()));

  //Cubit
  sl.registerFactory(() => CountCubit());
  sl.registerFactory(() => RegisterCubit());
  sl.registerFactory(() => ObsecureCubit());
  sl.registerFactory(() => EditProfileCubit());
  sl.registerFactory(() => ImageCubit());
  sl.registerFactory(() => NewPassCubit());
  sl.registerFactory(() => ValidatePassCubit());
  sl.registerFactory(() => OldPassCubit());

  //UseCase
  sl.registerLazySingleton(() => DashboardUseCase(sl()));
  sl.registerLazySingleton(() => AuthUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => ProfileUseCase(sl()));
  sl.registerLazySingleton(() => ResetPassUseCase(sl()));
  sl.registerLazySingleton(() => ChangePassUseCase(sl()));

  //repository
  sl.registerLazySingleton<IDashboardRepository>(
      () => DashboardRepository(sl()));
  sl.registerLazySingleton<IAuthRepository>(
      () => AuthRepository(dataSources: sl()));
  sl.registerLazySingleton<IProfileRepository>(() => ProfileRepository(sl()));

  //DataSources
  sl.registerLazySingleton<IDashboardDataSources>(() => DashboardDataSources());
  sl.registerLazySingleton<IAuthDataSources>(() => AuthDataSources());
  sl.registerLazySingleton<IProfileDataSources>(() => ProfileDataSources());
}
