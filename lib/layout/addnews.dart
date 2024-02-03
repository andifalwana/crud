
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'addnewsform.dart';
import '../bloc/addnews_bloc.dart';

class NewsForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddnewsBloc, AddnewsState>(
      builder: (context, state) {
      if (state is AddNewsInitialState) {
        return AddNewsForm();
      }else if (state is AddNewsLoadingState) {
        return CircularProgressIndicator();
      }else if (state is AddNewsSuccessState) {
        return AddNewsForm();
      }else if (state is AddNewsErrorState) {
        return Text('Error: ${state.error}');
      }else {
        return Container();
      }
    },);
  }
}