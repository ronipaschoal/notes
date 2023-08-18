import 'package:notes/models/note/note_model.dart';

abstract interface class INoteService {
  Future<List<NoteModel>> getNoteList();
}
