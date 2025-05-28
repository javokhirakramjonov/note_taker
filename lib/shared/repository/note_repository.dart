import 'package:note_taker/shared/model/note.dart';

class NoteRepository {
  final List<Note> notes = List.generate(
    10,
    (index) => Note(
      id: index + 1,
      title: 'Note ${index + 1}',
      content: index % 2 == 0
          ? 'This is the content of note ${index + 1}.'
          : 'This is a different content for note ${index + 1}. It has some variations to make it interesting. This is a different content for note ${index + 1}. It has some variations to make it interesting.',
    ),
  );

  Future<List<Note>> getNotes() async {
    return notes;
  }
}
