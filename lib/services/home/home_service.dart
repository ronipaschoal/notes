import 'package:notes/datasources/repositories/note/i_note_repositorie.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/services/home/i_home_service.dart';

class HomeService implements IHomeService {
  final INoteRepository repository;

  HomeService({required this.repository});

  @override
  Future<List<NoteModel>> getNoteList() async {
    return await repository.getNoteList();
  }
}
