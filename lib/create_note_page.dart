import 'package:flutter/material.dart';

class CreateNotePage extends StatefulWidget {
  @override
  _CreateNotePageState createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  String description = "";
  var textController = TextEditingController();
  var isEdit = false;

  @override
  void initState() {
    verifyIfDescriptionAlreadyExists();
    super.initState();
  }

  void verifyIfDescriptionAlreadyExists() {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        if (ModalRoute.of(context)!.settings.arguments != null) {
          description = ModalRoute.of(context)!.settings.arguments as String;
          textController.text = description;
          isEdit = true;
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Note" : "Create Note"),
        centerTitle: true,
        actions: [
          if (isEdit) deleteButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            descriptionTextField(),
            SizedBox(
              height: 32,
            ),
            if (description.isNotEmpty) saveButton()
          ],
        ),
      ),
    );
  }

  Widget deleteButton() {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        Navigator.pop(context, "");
      },
    );
  }

  Widget descriptionTextField() {
    return TextField(
      controller: textController,
      maxLines: null,
      onChanged: (value) {
        description = value;
        setState(() {});
      },
      decoration: InputDecoration(labelText: "Descrição"),
    );
  }

  Widget saveButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, description);
            },
            child: Text("Salvar"),
          ),
        ),
      ],
    );
  }
}
