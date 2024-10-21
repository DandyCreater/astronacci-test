import 'package:astronacci/feature/dashboard/domain/entity/user_resp_entity.dart';
import 'package:astronacci/feature/dashboard/domain/usecase/dashboard_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/gestures.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final DashboardUseCase dashboardUseCase;
  UserBloc(this.dashboardUseCase) : super(UserInitial()) {
    on<FetchUser>((event, emit) async {
      try {
        final result = await dashboardUseCase(event.page!);
        result.fold(
          (l) {
            emit(UserFailed(msg: l)); // Emit error state
          },
          (r) {
            List<DataUserEntity> listData = [];

            // If the current state is UserSuccess, combine existing data
            if (state is UserSuccess) {
              final oldData = (state as UserSuccess).data;
              listData.addAll(oldData);
            }

            // Add new data from the response
            listData.addAll(r.data);
            emit(UserSuccess(
                data: listData,
                isLoadingMore: event.isLoadingMore!)); // Emit the updated state
          },
        );
      } catch (e) {
        emit(UserFailed(msg: "Bloc User Error")); // Catch any errors
      }
    });

    on<SearchUser>((event, emit) async {
      try {
        emit(UserLoading());

        final res1 = await dashboardUseCase(1);
        final res2 = await dashboardUseCase(2);

        res1.fold(
          (l) {
            emit(UserFailed(msg: l));
          },
          (r1) {
            res2.fold(
              (l) {
                emit(UserFailed(msg: l));
              },
              (r2) {
                List<DataUserEntity> listData = [];
                listData.addAll(r1.data);
                listData.addAll(r2.data);

                final data = listData.where((element) {
                  final nameLower = event.name!.toLowerCase();
                  return element.firstName.toLowerCase().contains(nameLower) ||
                      element.lastName.toLowerCase().contains(nameLower);
                }).toList();

                emit(UserSuccess(data: data, isLoadingMore: false));
              },
            );
          },
        );
      } catch (e) {
        emit(const UserFailed(msg: "Bloc User Error"));
      }
    });
  }
}
