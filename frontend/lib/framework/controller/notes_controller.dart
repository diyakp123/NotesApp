import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/framework/models/note.dart';


final noteController = ChangeNotifierProvider((ref) => NoteController());


class NoteController extends ChangeNotifier{
   
}