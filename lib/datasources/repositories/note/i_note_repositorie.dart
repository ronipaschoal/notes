import 'package:notes/models/note/note_model.dart';

abstract interface class INoteRepository {
  Future<List<NoteModel>> getNoteList();
}
