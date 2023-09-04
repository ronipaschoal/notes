import 'dart:convert';
import 'package:notes/datasources/cache/note/i_note_cache.dart';
import 'package:notes/helpers/endpoints.dart';
import 'package:notes/config/http_client/i_http_client.dart';
import 'package:notes/datasources/dtos/note/note.dart';
import 'package:notes/config/either.dart';
import 'package:notes/datasources/repositories/note/i_note_repositorie.dart';
import 'package:notes/models/note/note_model.dart';

class NoteRepository implements INoteRepository {
  final INoteCache cache;
  final IHttpClient httpClient;

  NoteRepository({required this.cache, required this.httpClient});

  @override
  Future<Either<Exception, void>> createNote(NoteModel note) async {
    try {
      await httpClient.post(
        EndpointHelper.create,
        data: _toDto(note).toJson(),
      );
      return Success(null);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<List<NoteModel>> readNoteList() async {
    try {
      List<NoteModel> noteList = [];
      final response = await httpClient.get(EndpointHelper.list);
      final data = json.decode(response.data) as List<dynamic>;
      data
          .map((element) => noteList.add(_toModel(NoteDto.fromMap(element))))
          .toList();
      await cache.saveNoteList(noteList);
      return noteList;
    } catch (e) {
      return await cache.getNoteList();
    }
  }

  @override
  Future<Either<Exception, void>> updateNote(NoteModel note) async {
    try {
      await httpClient.post(
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
      await httpClient.post(
        '${EndpointHelper.delete}?id=${note.id}',
      );
      return Success(null);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, void>> sync() async {
    try {
      final noteList = await cache.getNoteListToSync();

      noteList.map((note) async {
        (note.id!.startsWith('[TP]-'))
            ? await createNote(note)
            : await updateNote(note);
      }).toList();
      return Success(null);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<void> saveNoteList(List<NoteModel> noteList) async {
    await cache.saveNoteList(noteList);
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
