import 'dart:convert';
import 'dart:developer';

import 'package:frontend/framework/models/note.dart';
import 'package:http/http.dart' as http;

class NoteService {
  static const String _baseUrl = "http://10.0.2.2:5000/notes";

  static Future<List<Note>> getNotes(String userid) async {
    Uri requesrUri = Uri.parse("$_baseUrl/list");
    List<Note> notes = [];
    try {
      var res = await http.post(requesrUri, body: {"userid": userid});
      print(res.body);
      var decoded = jsonDecode(res.body);
      for (var noteMap in decoded) {
        print(noteMap);
        Note newNote = Note.fromMap(noteMap);
        notes.add(newNote);
      }
    } catch (e, s) {
      print("Some Error Occured ${e}");
      print("Some Error Occured ${s}");
    }
    return notes;
    // return [];
  }

  static void addNote(Note note) async {
    print("Before Hitting API");
    Uri requesrUri = Uri.parse("$_baseUrl/add");
    print(requesrUri);
    try {
      var res = await http.post(requesrUri, body: note.toMap());
      print("Request Success => ${res}");
      print("Response Body ${res.body}");
      print("Response Body ${res.statusCode}");
      print("Response Body ${res.headers}");
    } catch (e) {
      print("Some Error Occured ${e}");
    }

    //  var decoded = jsonDecode(res.body);
    //  log(decoded);
  }

  static void deleteNote(Note note) async {
    print("Before Hitting API");
    Uri requesrUri = Uri.parse("$_baseUrl/delete");
    print(requesrUri);
    try {
      var res = await http.post(requesrUri, body: note.toMap());
      // print("Request Success => ${res}");
      // print("Response Body ${res.body}");
      // print("Response Body ${res.statusCode}");
      //       print("Response Body ${res.headers}");
    } catch (e) {
      print("Some Error Occured ${e}");
    }

    //  var decoded = jsonDecode(res.body);
    //  log(decoded);
  }
}
