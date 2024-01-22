import 'package:flutter/material.dart';
import 'package:my_project/constant/linkapi.dart';
import 'package:my_project/model/notemodel.dart';

class CardNote extends StatelessWidget {
  final void Function()? onDelete;
  final void Function() ontap;
  final Kemo notemodel;
  const CardNote(
      {super.key, required this.ontap, required this.notemodel, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Image.network(
                  "$linkImageRoot/${notemodel.notesImage}",
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("${notemodel.notesTitle}"),
                  subtitle: Text("${notemodel.notesContent}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_forever),
                    onPressed: onDelete,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
