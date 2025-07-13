import 'package:flutter/material.dart';
import 'package:fluttercourse/Models/notesmodel.dart';
import 'package:fluttercourse/auth/linkapi.dart';

class Cardnote extends StatelessWidget {
  final NoteModel notemodel;
  final void Function() tap;
  final void Function()? longPress;
  const Cardnote(
      {super.key,

      required this.tap, this.longPress, required this.notemodel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress:longPress ,
      onTap: tap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(400),
                    child: Image.network(
                      "$linkImageSource/${notemodel.notesImage}",
                      height: 90,
                      fit: BoxFit.fill,
                    ))),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text("${notemodel.notesTitle}"),
                subtitle: Text('${notemodel.notesContent}'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
