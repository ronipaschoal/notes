import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:notes/helpers/endpoints.dart';
import 'package:notes/config/http_client/http_client.dart';
import 'package:notes/config/http_client/i_http_client.dart';
import 'package:notes/datasources/dtos/note/note.dart';
import 'package:notes/config/either.dart';
import 'package:notes/datasources/repositories/note/i_note_repositorie.dart';
import 'package:notes/models/note/note_model.dart';

class NoteRepository implements INoteRepository {
  final IHttpClient _httpClient = HttpClient(Dio());

  NoteRepository();

  @override
  Future<Either<Exception, List<NoteModel>>> getNoteList() async {
    try {
      List<NoteModel> noteList = [];
      final response = await _httpClient.get(EndpointHelper.list);
      final data = json.decode(response.data) as List<dynamic>;
      data
          .map((element) => noteList.add(toModel(NoteDto.fromMap(element))))
          .toList();
      return Success(noteList);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }
}

NoteModel toModel(NoteDto dto) {
  return NoteModel(
    id: dto.id,
    title: dto.title,
    content: dto.content,
    priority: PriorityEnum.values[dto.priority],
  );
}
