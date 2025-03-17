import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/framework/controller/new_note_controller.dart';
import 'package:frontend/framework/controller/notes_controller.dart';
import 'package:frontend/framework/notes_repository/note_service.dart';
import 'package:frontend/pages/add_new_note_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // NoteService.getNotes();
    ref.read(newNoteController).getNotes();

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: const Text("Notes App"),
          centerTitle: true,
        ),
        body: Consumer(builder: (context, ref, child) {
          // final notewatch = ref.watch(newNoteController.select((d) => d.notes));
          final noteWatch = ref.watch(newNoteController);
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  noteWatch.clearTextField();
                  noteWatch.addControllerValue(noteWatch.notes[index]);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => AddNewNotePage(
                              isUpdate: true, note: noteWatch.notes[index])));
                },
                onLongPress: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 113, 173, 219),
                  ),
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 1,
                          noteWatch.notes[index].title.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          noteWatch.notes[index].content.toString(),
                          maxLines: 3,
                        ),
                        const Spacer(),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(onTap: () {
                              noteWatch.deleteNote(noteWatch.notes[index]);
                            }, child: Icon(Icons.delete))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: noteWatch.notes.length,
          );
        }),
        floatingActionButton: Consumer(builder: (context, ref, child) {
          final noteWatch = ref.watch(newNoteController);
          return FloatingActionButton(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
            onPressed: () {
              noteWatch.clearTextField();
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => const AddNewNotePage(
                            isUpdate: false,
                          )));
            },
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
