import 'dart:convert';
import 'package:notesapp/models/api_response.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/models/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'package:notesapp/models/note_insert.dart';

class NotesService {
  static const API = 'http://api.notes.programmingaddict.com';
  static const headers = {
    'apiKey': 'bf0ead39-2e12-400d-b7b2-8e36df2c0a1d',
    'Content-Type': 'application/json'
  };

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(API + '/notes', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          notes.add(NoteForListing.fromJson(item));
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(
          error: true, errormessage: 'An Error has been occured');
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errormessage: 'An Error has been occured'));
  }

  Future<APIResponse<Note>> getNote(String noteID) {
    return http.get(API + '/notes/' + noteID, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        return APIResponse<Note>(data: Note.fromJson(jsonData));
      }
      return APIResponse<Note>(
          error: true, errormessage: 'An Error has been occured');
    }).catchError((_) => APIResponse<Note>(
        error: true, errormessage: 'An Error has been occured'));
  }

  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http
        .post(API + '/notes',
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errormessage: 'An Error has been occured');
    }).catchError((_) => APIResponse<bool>(
            error: true, errormessage: 'An Error has been occured'));
  }

  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http
        .put(API + '/notes/' + noteID,
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errormessage: 'An Error has been occured');
    }).catchError((_) => APIResponse<bool>(
            error: true, errormessage: 'An Error has been occured'));
  }

  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http.delete(API + '/notes/' + noteID, headers: headers).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errormessage: 'An Error has been occured');
    }).catchError((_) => APIResponse<bool>(
        error: true, errormessage: 'An Error has been occured'));
  }
}
