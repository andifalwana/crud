import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:crud/bloc/editnews_bloc.dart';

class EditForm extends StatefulWidget {
  final String id, title, url, descr, date;
  const EditForm({required this.id, required this.title, this.url ="", required this.descr, required this.date});

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  File? _pickedImage;
  @override
  void initState(){
    super.initState();
    titleController.text = widget.title;
    contentController.text = widget.descr;
    dateController.text = widget.date;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AddNews')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Content'),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(
                      2000), 
                    lastDate: DateTime(2101));
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        dateController.text = formattedDate;
                      });
                    }
                },
              ),
              _pickedImage == null
              ? Image.network(widget.url, width: double.infinity, fit: BoxFit.cover,): const SizedBox.shrink(),
              _pickedImage != null
              ? SizedBox(
                width: double.infinity,
                child: Image.file(_pickedImage!, fit: BoxFit.contain,)
              ): const SizedBox.shrink(),
              ElevatedButton(
                onPressed: (){
                  if ((_pickedImage == null && widget.url == "") || titleController.text == "" ||contentController.text == "" || dateController.text =="") {
                    showDialog(context: context, 
                    builder: (ctx) => AlertDialog(
                      title: const Text('No Image'),
                      content: const SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('Silahkan Lengkapi data'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          }, child: const Text('Ok'),),
                      ],
                    ));
                  }
                  else {
                    final id = widget.id;
                    final title = titleController.text;
                    final content = contentController.text;
                    final date = dateController.text;
                    final image = _pickedImage;

                    context.read<EditnewsBloc>().add(ClickEdit(id: id, title: title, content: content, date: date, image: image));
                  }
                  
                }, child: const Text("Edit News")),
            ],
          ),
        ),),
    );
  }
}