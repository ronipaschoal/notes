import 'package:notes/config/either.dart';
import 'package:notes/models/note/note_model.dart';

abstract interface class INoteRepository {
  Future<Either<Exception, void>> createNote(NoteModel note);
  Future<List<NoteModel>> readNoteList();
  Future<Either<Exception, void>> updateNote(NoteModel note);
  Future<Either<Exception, void>> deleteNote(NoteModel note);
  Future<Either<Exception, void>> sync();
  Future<void> saveNoteList(List<NoteModel> noteList);
}
