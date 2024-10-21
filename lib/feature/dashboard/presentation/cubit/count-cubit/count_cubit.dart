import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class CountCubit extends Cubit<int> {
  CountCubit() : super(0);

  void setCount(int count) => emit(count);
}
