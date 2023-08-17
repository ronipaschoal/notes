import 'package:notes/datasources/repositories/note/i_note_repositorie.dart';
import 'package:notes/datasources/repositories/note/note_mock.dart';
import 'package:notes/models/note/note_model.dart';

class NoteRepository implements INoteRepository {
  @override
  Future<List<NoteModel>> getNoteList() async {
    return noteListMock;
  }
}
