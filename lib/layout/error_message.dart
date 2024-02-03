import 'package:flutter/material.dart';

class ErrorMessage extends StatefulWidget {
  final String message;
  const ErrorMessage({required this.message});

  @override
  State<ErrorMessage> createState() => _ErrorMessageState();
}

class _ErrorMessageState extends State<ErrorMessage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.message), 
      actions: [
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
            },
            child: Text("Ok"))
            ], );
  }
}
// class ErrorMessage extends StatelessWidget {
//   final String message;

//   ErrorMessage({required this.message});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Error : $message'),
//     );
//   }
// }