part of 'managenews_bloc.dart';

@immutable
sealed class ManagenewsState extends Equatable {}

final class ManagenewsInitial extends ManagenewsState {
  final List news;
  final String searchText;

  ManagenewsInitial({required this.news, this.searchText = ""});

  @override
  List<Object> get props => [news, searchText];
}

final class LoadingManagenews extends  ManagenewsState {
  @override
  List<Object> get props => [];
}

