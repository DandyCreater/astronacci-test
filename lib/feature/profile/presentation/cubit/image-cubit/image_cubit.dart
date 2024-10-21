import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ImageCubit extends Cubit<String> {
  ImageCubit() : super("");

  void setImage(String imageUrl) => emit(imageUrl);
}
