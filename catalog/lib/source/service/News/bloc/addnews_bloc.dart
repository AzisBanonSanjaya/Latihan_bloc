import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:catalog/source/repository/newsrepo.dart';
import 'package:meta/meta.dart';

part 'addnews_event.dart';
part 'addnews_state.dart';

class AddnewsBloc extends Bloc<AddnewsEvent, AddnewsState> {
  final NewsRepository? newsRepository;
  AddnewsBloc({required this.newsRepository}) : super(AddnewsInitialState()) {
    on<AddnewsInitial>(addNews);
  }
  addNews(AddnewsInitial event, Emitter emit) async {
  try {
      emit(AddnewsLoadingState());
    final result = await newsRepository!.addNews(
      title: event.title,
      desc: event.desc,
      date: event.date,
      image: event.image,
    );
    emit(AddnewsSuccessState(message: result));
    await Future.delayed(const Duration(seconds: 2));
    emit(AddnewsInitialState());
  } catch (e) {
    emit(AddnewsErrorState(messageError: "ERROR: $e"));
  }
  }
}
