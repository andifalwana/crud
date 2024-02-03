import 'package:crud/bloc/detail_bloc.dart';
import 'detailload.dart';
import 'error_message.dart';
import 'loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailNews extends StatefulWidget {
  final String newsId;
  const DetailNews({super.key, required this.newsId});

  @override
  State<DetailNews> createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<DetailBloc>().add(LoadNewsEvent(newsId: widget.newsId));
     });
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        if (state is DetailInitial) {
          return LoginIndicator();
        }else if (state is LoadFailed){
          return ErrorMessage(message: state.msg);
        }else if (state is NewsDeleted){
          return Scaffold(
            appBar: AppBar(title: const Text('Hapus sukses')),
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Text ("Berita '${state.title}' berhasil dihapus"),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pop('reload');
                        },
                        child: const Text('Kembali ke list berita'),
                      ),
                    )
                  ],
                ),
              ),),
          );
        }else if (state is DetailLoaded){
          return DetailViewLoad(id: state.news['id'], title: state.news['title'], url: state.news['img'], descr: state.news['descr'], date: state.news['date']);
        }else {
          return Scaffold(
            appBar: AppBar(title: const Text('error')),
            body: const Padding(padding: EdgeInsets.all(8.0),
            child: Center(child: Text('unknown Error'),),),
          );
        }
      });
  }
}