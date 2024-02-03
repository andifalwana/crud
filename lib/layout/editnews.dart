import 'editform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud/bloc/editnews_bloc.dart';
import 'loading.dart';
import 'error_message.dart';

class EditNews extends StatefulWidget {
  final String id, title, url, descr, date;
  const EditNews({required this.id, required this.title, this.url ="", required this.descr, required this.date});

  @override
  State<EditNews> createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<EditnewsBloc>().add(SetInit());
     });
     super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditnewsBloc, EditnewsState>(
      builder: (context, state){
        if (state is EditnewsInitial){
          return EditForm(id: widget.id, title: widget.title, url: widget.url, descr: widget.descr, date: widget.date);
        }else if (state is LoadingEdit) {
          return LoginIndicator();
        }else if (state is SuccesEdit){
          return Scaffold(
            appBar: AppBar(title: const Text("Edit News")),
            body:  SingleChildScrollView(
              child: Padding(padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      state.message, textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: ElevatedButton(child: const Text('Lihat Berita'),
                    onPressed: (){
                      Navigator.of(context).pop('reload');
                    },),
                  )
                ],
              ),),
            ),
          );
        }else if (state is ErrorEdit){
          return ErrorMessage(message: "gagal edit");
        }else {
          return Container();
        }
      });
  }
}