import 'package:notes/config/either.dart';
import 'package:notes/models/note/note_model.dart';

abstract interface class INoteService {
  Future<Either<Exception, void>> createNote(NoteModel note);
  Future<Either<Exception, List<NoteModel>>> readNoteList();
  Future<Either<Exception, void>> updateNote(NoteModel note);
  Future<Either<Exception, void>> deleteNote(NoteModel note);
}
