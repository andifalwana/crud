import 'package:crud/bloc/detail_bloc.dart';
import 'package:crud/bloc/editnews_bloc.dart';
import 'package:crud/bloc/managenews_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crud/repository/login_repository.dart';
import 'layout/homepage.dart';
import 'bloc/login_bloc.dart';
import 'package:crud/bloc/addnews_bloc.dart';
import 'package:crud/repository/news_repository.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => LoginRepository(),
          ),
          RepositoryProvider(
            create: (context) => NewsRepository(), 
            ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => 
              LoginBloc(loginRepository: context.read<LoginRepository>())
              ..add(InitLogin())
            ),
            BlocProvider(
              create: (context) =>
              AddnewsBloc(newsRepository: context.read<NewsRepository>())
              ),
            BlocProvider(
              create: (context) => ManagenewsBloc(newsRepository: context.read<NewsRepository>())
              ),
            BlocProvider(
              create: (context) => DetailBloc(newsRepository: context.read<NewsRepository>())
              ),
            BlocProvider(
              create: (context) => EditnewsBloc(newsRepository: context.read<NewsRepository>())
              ),
          ],
          child: MaterialApp(
            title: "Home",
            home: HomePage(),
          ),
        )
      
    );
  }
}

