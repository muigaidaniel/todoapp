import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/database/note.dart';
import '/database/notes.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  final Item item;
  final int index;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {

  bool value=false;
  @override
  Widget build(BuildContext context) {
    final created = DateFormat('d MMM y  kk:mm').format(widget.item.created);
    final isdone =widget.item.isDone;

    return Card(
      elevation: 10,
      color: Colors.white,
      child: Container(
        constraints: const BoxConstraints(minHeight: 100),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.title,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  created,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
            Checkbox(
              value: value,
              onChanged:
                  (value) async {
                setState((){
                  this.value=value!;});debugPrint('$value,${widget.item.isDone}');},
            ),
          ],
        ),
      ),
    );
  }

}
