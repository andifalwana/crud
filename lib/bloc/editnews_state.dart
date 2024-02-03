part of 'editnews_bloc.dart';

@immutable
sealed class EditnewsState extends Equatable {}

final class EditnewsInitial extends EditnewsState {
  @override
  List<Object?> get props => [];
}
final class LoadingEdit extends EditnewsState {
  @override
  List<Object?> get props => [];
}
final class SuccesEdit extends EditnewsState {
  final String message;
  SuccesEdit({required this.message});
  @override
  List<Object?> get props => [message];
}
final class ErrorEdit extends EditnewsState {
  final String error;
  ErrorEdit({required this.error});
  @override
  List<Object?> get props => [error];
}
