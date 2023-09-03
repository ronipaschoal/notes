import 'package:notes/config/either.dart';
import 'package:notes/models/note/note_model.dart';

abstract interface class INoteCache {
  Future<Either<Exception, void>> saveNoteList(List<NoteModel> noteList);
  Future<List<NoteModel>> getNoteList();
  Future<List<NoteModel>> getNoteListToSync();
  Future<Either<Exception, void>> clearNoteList();
}
