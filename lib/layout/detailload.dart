import 'dart:developer';
import 'package:crud/bloc/detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'editnews.dart';

class DetailViewLoad extends StatefulWidget {
  final String id, title, url, descr, date;
  const DetailViewLoad({required this.id, required this.title, required this.url, required this.descr, required this.date});

  @override
  State<DetailViewLoad> createState() => _DetailViewLoadState();
}

class _DetailViewLoadState extends State<DetailViewLoad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: (){
            showOptionDialog(context).then((res){
            log("RES $res");
            if (res == 'delete'){
              context.read<DetailBloc>().add(DeleteNews(id: widget.id, title: widget.title));
            }else if (res == 'edit'){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => EditNews(id: widget.id, title: widget.title, url: widget.url, descr: widget.descr, date: widget.date)),).then((value) {
                  if (value == 'reload'){
                    context.read<DetailBloc>().add(LoadNewsEvent(newsId: widget.id));
                  }
                });
            };
            });
          },),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(widget.title,
              style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              Image.network(
                widget.url,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(widget.descr, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
            ],
          ),
        ),),
    );
  }
  Future showOptionDialog(BuildContext context) {
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('kelola data'),
          content: const Text('Apa yang ingin anda lakukan?'),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop('edit');
              }, child: const Text('Edit'),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop('delete');
                }, child: const Text('Delete')),
          ],
        );
      },);
  }
}
