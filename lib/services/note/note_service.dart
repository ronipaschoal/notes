import 'package:notes/datasources/repositories/note/i_note_repositorie.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/services/note/i_note_service.dart';

class NoteService implements INoteService {
  final INoteRepository repository;

  NoteService({required this.repository});

  @override
  Future<List<NoteModel>> getNoteList() async {
    return await repository.getNoteList();
  }
}
