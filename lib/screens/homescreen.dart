import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '/components/card.dart';
import '/database/note.dart';
import '/database/notes.dart';
import '/screens/add_and_edit.dart';
import '/screens/note_details.dart';

class Homescreen extends StatefulWidget {
  final Item? item;

  const Homescreen({Key? key, this.item}) : super(key: key);
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late List<Item> items;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    items = await Items.instance.readAll();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'To Do',
            style: TextStyle(fontSize: 24,color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: isLoading
              ? SpinKitRotatingCircle(
                  color: Theme.of(context).primaryColor,
                )
              : items.isEmpty
                  ? const Text(
                    'To do list is empty',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final note = items[index];
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  NoteDetailPage(noteId: note.id!),
                            ));
                            refreshNotes();
                          },
                          child:NoteCard(item: note, index: index),
                        );
                      },
                    ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditNotePage()),
            );
            refreshNotes();
          },
        ),
      );
}
