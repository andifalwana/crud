import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:crud/repository/news_repository.dart';

part 'addnews_event.dart';
part 'addnews_state.dart';

class AddnewsBloc extends Bloc<AddnewsEvent, AddnewsState> {
  final NewsRepository newsRepository;

  AddnewsBloc({required this.newsRepository}) : super(AddNewsInitialState()) {
    on<AddnewsInitial>(_addnews);
  }
  _addnews(AddnewsInitial event, Emitter emit) async {
    try {
      emit(AddNewsLoadingState());

      final result = await newsRepository.addNews(title: event.title, content: event.content, date: event.date, image: event.image);
      emit(AddNewsSuccessState(message: result));
      await Future.delayed(Duration(seconds: 3));
      emit(AddNewsInitialState());
    }catch (error) {
      emit(AddNewsErrorState(error: 'Error: $error'));
    }
  }
}