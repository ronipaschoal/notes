import 'dart:convert';

import 'package:notes/config/either.dart';
import 'package:notes/datasources/cache/note/i_note_cache.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteCache implements INoteCache {
  @override
  Future<Either<Exception, void>> saveNoteList(List<NoteModel> noteList) async {
    try {
      final instance = await SharedPreferences.getInstance();
      instance.setString(
        'notes',
        jsonEncode(noteList),
      );
      return Success(null);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<List<NoteModel>> getNoteList() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final json = instance.getString('notes');
      final noteList = <NoteModel>[];
      if (json != null) {
        (jsonDecode(json) as List<dynamic>)
            .map((element) => noteList.add(NoteModel.fromJson(element)))
            .toList();
      }
      return noteList;
    } catch (e) {
      return <NoteModel>[];
    }
  }

  @override
  Future<List<NoteModel>> getNoteListToSync() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final json = instance.getString('notes');
      final noteList = <NoteModel>[];
      if (json != null) {
        (jsonDecode(json) as List<dynamic>)
            .map((element) => noteList.add(NoteModel.fromJson(element)))
            .toList();
      }
      return noteList.where((element) => element.updatedAt == null).toList();
    } catch (e) {
      return <NoteModel>[];
    }
  }

  @override
  Future<Either<Exception, void>> clearNoteList() async {
    try {
      final instance = await SharedPreferences.getInstance();
      instance.clear();
      return Success(null);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }
}
