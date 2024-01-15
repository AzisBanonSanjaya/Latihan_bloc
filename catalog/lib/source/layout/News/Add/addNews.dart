import 'package:catalog/source/layout/News/Add/addNewsForm.dart';
import 'package:catalog/source/service/News/bloc/addnews_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsForm extends StatelessWidget {
  const NewsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddnewsBloc, AddnewsState>(
        builder: (context, state) {
          if (state is AddnewsInitialState) {
            return AddNewsForm();
          } else if (state is AddnewsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AddnewsSuccessState) {
            return Center(
              child: Text(state.message!.toString()),
            );
          } else if (state is AddnewsErrorState) {
            return Center(
              child: Text(state.messageError!),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
