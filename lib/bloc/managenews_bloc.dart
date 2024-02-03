import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:crud/repository/news_repository.dart';

part 'managenews_event.dart';
part 'managenews_state.dart';

class ManagenewsBloc extends Bloc<ManagenewsEvent, ManagenewsState> {
  NewsRepository newsRepository;
  ManagenewsBloc({required this.newsRepository}) : super(LoadingManagenews()) {
    on<LoadListNewsEvent>(_loadList);
  }
  _loadList(LoadListNewsEvent event, Emitter emit) async {
     String key = event.keyword;
     emit(LoadingManagenews());
     List res = await newsRepository.getNewsList(key);
     emit(ManagenewsInitial(news: res, searchText: key));
  }
}
