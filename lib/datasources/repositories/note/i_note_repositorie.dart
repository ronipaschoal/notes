import 'package:notes/config/either.dart';
import 'package:notes/models/note/note_model.dart';

abstract interface class INoteRepository {
  Future<Either<Exception, List<NoteModel>>> getNoteList();
  Future<Either<Exception, void>> createNote(NoteModel note);
  Future<Either<Exception, void>> updateNote(NoteModel note);
}
