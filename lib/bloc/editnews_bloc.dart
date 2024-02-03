import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:crud/repository/news_repository.dart';

part 'editnews_event.dart';
part 'editnews_state.dart';

class EditnewsBloc extends Bloc<EditnewsEvent, EditnewsState> {
  final NewsRepository newsRepository;
  EditnewsBloc({required this.newsRepository}) : super(EditnewsInitial()) {
    on<SetInit>(_setInit);
    on<ClickEdit>(_editnews);
  }
  _setInit(SetInit event, Emitter emit){
    emit (EditnewsInitial());
  }
  _editnews(ClickEdit event, Emitter emit) async {
    try {
      emit(LoadingEdit());
      bool result = await newsRepository.editNews(id: event.id, title: event.title, content: event.content, date: event.date, image: event.image);
      if (result == true){
        emit(SuccesEdit(message: "Berita ${event.title} Berhasil diubah"));
      }else {
        emit(ErrorEdit(error: 'Error: Gagal merubah berita'));
      }
    }catch (error){
      emit(ErrorEdit(error: 'Error: $error'));
    }
  }
}
