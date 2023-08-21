import 'package:notes/datasources/either.dart';
import 'package:notes/models/note/note_model.dart';

abstract interface class INoteService {
  Future<Either<Exception, List<NoteModel>>> getNoteList();
}
