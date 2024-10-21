part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUser extends UserEvent {
  final int? page;
  final bool? isLoadingMore;
  const FetchUser(this.page, this.isLoadingMore);

  @override
  // TODO: implement props
  List<Object> get props => [page!, isLoadingMore!];
}

class SearchUser extends UserEvent {
  final String? name;

  const SearchUser(this.name);
  @override
  // TODO: implement props
  List<Object> get props => [name!];
}
