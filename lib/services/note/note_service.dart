import 'package:notes/config/either.dart';
import 'package:notes/datasources/repositories/note/i_note_repositorie.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/services/note/i_note_service.dart';

class NoteService implements INoteService {
  final INoteRepository repository;

  NoteService({required this.repository});

  @override
  Future<Either<Exception, List<NoteModel>>> getNoteList() async {
    return await repository.getNoteList();
  }

  @override
  Future<Either<Exception, void>> createNote(NoteModel note) async {
    return await repository.createNote(note);
  }

  @override
  Future<Either<Exception, void>> updateNote(NoteModel note) async {
    return await repository.updateNote(note);
  }

  @override
  Future<Either<Exception, void>> deleteNote(NoteModel note) async {
    return await repository.deleteNote(note);
  }
}
