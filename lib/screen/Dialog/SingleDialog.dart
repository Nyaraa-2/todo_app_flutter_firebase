import 'package:flutter/material.dart';

class SingleDialog extends StatelessWidget {
  const SingleDialog(
      {Key? key,
      required this.title,
      required this.content,
      this.textOKButton = "Valider",
      this.textCancelButton = "Annuler",
      required this.callbackOK,
      required this.callbackCancel})
      : super(key: key);

  final Widget content;

  final String title;
  final String textOKButton;
  final String textCancelButton;

  final Function callbackOK;
  final Function callbackCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        ElevatedButton(
          onPressed: () {
            if(callbackOK()){
            Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple[100]),
          child: Text(textOKButton,style: const TextStyle(color: Colors.black)),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            callbackCancel();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
          child: Text(textCancelButton,style: const TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
