part of 'addnews_bloc.dart';

@immutable
sealed class AddnewsEvent {}

final class AddnewsInitial extends AddnewsEvent {
  final String? title;
  final String? desc;
  final String? date;
  final File? image;

  AddnewsInitial({required this.title, required this.desc, required this.date, required this.image});
  List<Object> get props => [title!, desc!, date!, image!];
}
