import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notes = <String>["Primeiro Item"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NOTES"),
        centerTitle: true,
      ),
      body: notesListWidget(),
      floatingActionButton: addButtonWidget(),
    );
  }

  Widget notesListWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var i = 0; i < notes.length; i++)
            noteCardWidget(textNoteIndex: i),
        ],
      ),
    );
  }

  Widget noteCardWidget({required int textNoteIndex}) {
    return Card(
      child: ListTile(
        title: Text(notes[textNoteIndex]),
        onTap: () async {
          var response = await Navigator.pushNamed(context, "/create-note",
              arguments: notes[textNoteIndex]);
          if (response != null) {
            var description = response as String;
            if (description.isEmpty)
              notes.remove(notes[textNoteIndex]);
            else
              notes[textNoteIndex] = description;
            setState(() {});
          }
        },
      ),
    );
  }

  Widget addButtonWidget() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        var description = await Navigator.pushNamed(context, "/create-note");
        if (description != null) {
          notes.add(description as String);
          setState(() {});
        }
      },
    );
  }
}
