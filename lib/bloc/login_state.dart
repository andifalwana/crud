part of 'login_bloc.dart';

@immutable
sealed class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSucces extends LoginState {
  final String sessionToken; //gk pake final

  LoginSucces({required this.sessionToken});
  @override
  List<Object> get props => [sessionToken];
}

class LoginFailure extends LoginState{
  final String error; //gk ada final

  LoginFailure({required this.error});
  @override
  List<Object> get props => [error];
}