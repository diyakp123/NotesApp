import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/framework/controller/new_note_controller.dart';
import 'package:frontend/framework/models/note.dart';

class AddNewNotePage extends ConsumerStatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNotePage({super.key, required this.isUpdate, this.note});

  @override
  ConsumerState<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends ConsumerState<AddNewNotePage> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   if (widget.isUpdate) {
  //     // final noteWatch =   ref.watch(newNoteController);
  //     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
  //       // ref.read(newNoteController).clearTextField();
  //       ref.read(newNoteController).updateNote(widget.note!);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          actions: [
            Consumer(builder: (context, ref, child) {
              final noteWatch = ref.watch(newNoteController);
              return IconButton(
                  onPressed: () {
                    if(widget.isUpdate){
                      noteWatch.updateNote(widget.note!);
                    }
                    else{
                    noteWatch.addNote();

                    }
                    // noteWatch.getNotes();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.check));
            })
          ],
        ),
        body: Consumer(builder: (context, ref, child) {
          final newNoteWatch = ref.watch(newNoteController);
          return Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  TextFormField(
                    autofocus: widget.isUpdate == true ? false : true,
                    onFieldSubmitted: (v) {
                      newNoteWatch.changeFocus();
                    },
                    controller: newNoteWatch.titleController,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Title",
                      border: InputBorder.none,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: null,
                      focusNode: newNoteWatch.noteContentFocus,
                      controller: newNoteWatch.contentController,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        hintText: "content",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
