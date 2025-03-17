import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/framework/models/note.dart';
import 'package:frontend/framework/notes_repository/note_service.dart';
import 'package:uuid/uuid.dart';

final newNoteController = ChangeNotifierProvider((ref) => NewNoteController());

class NewNoteController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  FocusNode noteContentFocus = FocusNode();

  List<Note> notes = [];

void getNotes()async{
  notes = await NoteService.getNotes("diya@gmail.com") ;
notifyListeners();
}


  void addNote() {
    Note myNote = Note(
        id: const Uuid().v1(),
        userid: "diya@gmail.com",
        dateadded: DateTime.now(),
        title: titleController.text,
        content: contentController.text);
    notes.add(myNote);
    notifyListeners();
    NoteService.addNote(myNote);
    // getNotes();
  }

  void updateNote(Note note) {
    int indexOfNote = notes.indexOf(
      notes.firstWhere((element) => element.id == note.id),
    );
    // print(object)
    note.title = titleController.text;
    note.content = contentController.text;
    notes[indexOfNote] = note;

    notifyListeners();
    NoteService.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    notifyListeners();
    NoteService.deleteNote(note);
  }

  void addControllerValue(Note note) {
    titleController.text = note.title!;
    contentController.text = note.content!;
    notifyListeners();
  }

  void changeFocus() {
    noteContentFocus.requestFocus();
    notifyListeners();
  }

  void clearTextField() {
    titleController.clear();
    contentController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    print("dfgg");
    titleController.dispose();
    contentController.dispose();
    noteContentFocus.dispose();
    super.dispose();
  }
}
