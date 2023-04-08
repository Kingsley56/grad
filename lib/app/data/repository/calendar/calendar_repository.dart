import 'dart:convert';

import 'package:Grad/app/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class CalendarRepository {
  static var client = http.Client();
  static Future<Map<String, dynamic>> uploadEvent({required data}) async {
    var url = Uri.parse("$grad$events/$uploadEvent");
    try {
      var response = await client.post(
        url,
        body: data,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (_) {
      throw Exception("Failed to load data");
    }
  }

  static Future<List<dynamic>> events({
    required term,
    required year,
    required school,
    required type,
    required per_page,
    required page,
  }) async {
    var url = Uri.parse("$grad$events/$getEvents/$per_page/$page");
    try {
      var response = await client.post(url, body: {
        "school": school,
        "type": type,
        "term": term,
        "year": year,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'];
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (_) {
      throw Exception("Failed to load data");
    }
  }

  ///
  /// update event
  ///
  static Future<Map<String, dynamic>> updateEvent({required data}) async {
    var url = Uri.parse("$grad$events/update");
    try {
      var response = await client.post(
        url,
        body: data,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (_) {
      throw Exception("Failed to load data");
    }
  }

  ///
  /// delete event
  ///
  static Future<Map<String, dynamic>> deleteEvent(
      {required school, required id}) async {
    var url = Uri.parse("$grad$events/delete/$id/$school");
    try {
      var response = await client.delete(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (_) {
      throw Exception("Failed to load data");
    }
  }
}
