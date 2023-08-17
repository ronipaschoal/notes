import 'package:notes/models/note/note_model.dart';

abstract interface class IHomeService {
  Future<List<NoteModel>> getNoteList();
}
