import 'package:flutter/material.dart';
import '/database/note.dart';
import '/components/form.dart';
import '/database/notes.dart';

class AddEditNotePage extends StatefulWidget {
  final Item? item;

  const AddEditNotePage({
    Key? key,
    this.item,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late int isDone;
  late int number;
  late String title;
  late String content;

  @override
  void initState() {
    super.initState();

    isDone = widget.item?.isDone ?? 0;
    number = widget.item?.number ?? 0;
    title = widget.item?.title ?? '';
    content = widget.item?.content ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteForm(
            isDone: isDone,
            number: number,
            title: title,
            content: content,
            onChangedisDone: (favourite) =>
                setState(() => isDone = isDone),
            onChangedNumber: (number) => setState(() => this.number = number),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedContent: (content) =>
                setState(() => this.content = content),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && content.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateItem,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateItem() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final isUpdating = widget.item != null;
      if (isUpdating) {
        await addItem();
      } else {
        await addItem();
      }
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  Future updateItem() async {
    final item = widget.item!.copy(
      isDone: isDone,
      number: number,
      title: title,
      content: content,
    );
    await Items.instance.update(item);
  }

  Future addItem() async {
    final item = Item(
      title: title,
      isDone: isDone,
      number: number,
      content: content,
      created: DateTime.now(),
    );

    await Items.instance.create(item);
  }
}
