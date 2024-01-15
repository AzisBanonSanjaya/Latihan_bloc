part of 'addnews_bloc.dart';

@immutable
sealed class AddnewsState {}

final class AddnewsInitialState extends AddnewsState {
  List<Object> get props => [];
}

final class AddnewsLoadingState extends AddnewsState {
  List<Object> get props => [];
}

final class AddnewsSuccessState extends AddnewsState {
  final String? message;

  AddnewsSuccessState({required this.message});
}

final class AddnewsErrorState extends AddnewsState {
  final String? messageError;

  AddnewsErrorState({required this.messageError});
  List<Object> get props => [messageError!];
}
