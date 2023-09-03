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
  Future<Either<Exception, void>> createNote(NoteModel note) async {
    try {
      await _httpClient.post(
        EndpointHelper.create,
        data: _toDto(note).toJson(),
      );
      return Success(null);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<NoteModel>>> readNoteList() async {
    try {
      List<NoteModel> noteList = [];
      final response = await _httpClient.get(EndpointHelper.list);
      final data = json.decode(response.data) as List<dynamic>;
      data
          .map((element) => noteList.add(_toModel(NoteDto.fromMap(element))))
          .toList();
      return Success(noteList);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, void>> updateNote(NoteModel note) async {
    try {
      await _httpClient.post(
        EndpointHelper.update,
        data: _toDto(note).toJson(),
      );
      return Success(null);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, void>> deleteNote(NoteModel note) async {
    try {
      await _httpClient.post(
        '${EndpointHelper.delete}?id=${note.id}',
      );
      return Success(null);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }
}

NoteModel _toModel(NoteDto dto) {
  return NoteModel(
    id: dto.id,
    title: dto.title,
    content: dto.content,
    priority: PriorityEnum.values[dto.priority],
    createdAt: DateTime.parse(dto.created),
    updatedAt: dto.updated != null ? DateTime.parse(dto.updated!) : null,
  );
}

NoteDto _toDto(NoteModel note) {
  return NoteDto(
    id: note.id ?? '',
    title: note.title,
    content: note.content,
    priority: note.priority?.index ?? 0,
    created: note.createdAt!.millisecondsSinceEpoch.toString(),
    updated: note.updatedAt?.millisecondsSinceEpoch.toString(),
  );
}
