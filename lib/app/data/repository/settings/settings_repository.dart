import 'dart:convert';

import 'package:grad/app/core/constants/api_constants.dart';
import 'package:grad/app/data/model/role_model.dart';
import 'package:http/http.dart' as http;

import '../../model/campus_model.dart';

class SettingsRepository {
  static var client = http.Client();

  static Future<Map<String, dynamic>> recoveryCode(
      String email, String school) async {
    var url = Uri.parse("$grad$recoveryCode");
    try {
      var response =
          await client.post(url, body: {"email": email, "school": school});
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (_) {
      return {"status": false, "message": "Oops, there was an error"};
    }
  }

  static Future<Map<String, dynamic>> verifyAccount(
    String email,
    String school,
    String code,
  ) async {
    var url = Uri.parse("$grad$verifyAccount");
    try {
      var response = await client.post(url, body: {
        "email": email,
        "school": school,
        "code": code,
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (_) {
      return {"status": false, "message": "Oops, there was an error"};
    }
  }

  static Future<List<dynamic>> getConfigSettings({
    required school,
  }) async {
    var url = Uri.parse("$grad$configSettings/$school");
    try {
      var response = await client.get(url);
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

  static Future<Map<String, dynamic>> updateSchoolConfig({
    required data,
  }) async {
    var url = Uri.parse("$grad$configSettings/$schoolConfig");
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

  static Future<Map<String, dynamic>> updateSession({
    required data,
  }) async {
    var url = Uri.parse("$grad$configSettings/$configSession");
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

  static Future<Map<String, dynamic>> updateTerm({
    required data,
  }) async {
    var url = Uri.parse("$grad$configSettings/$configTerm");
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
      print(_.toString());
      throw Exception("Failed to load data");
    }
  }

  static Future<Map<String, dynamic>> updateStamp(
      Map<String, dynamic> data) async {
    var url = Uri.parse("$grad$configSettings/$configStamp");
    try {
      var request = await http.MultipartRequest(
        "POST",
        url,
      );
      if (data['image'] != "")
        request.files.add(
          await http.MultipartFile.fromPath("image", data['image']),
        );
      request.fields['school'] = data['school'];

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        return {
          "status": false,
          "validate": false,
          "message": "Oops, there was an error"
        };
      }
    } catch (_) {
      return {
        "status": false,
        "validate": false,
        "message": "Oops, there was an error",
        "error": _.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> submitBugIssue({
    required data,
  }) async {
    var url = Uri.parse("$grad$configSettings/$bugIssues");
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

  static Future<List<Campus>> getCampus({
    required school,
  }) async {
    var url = Uri.parse("$grad$configSettings/campus/$school");
    try {
      var response = await client.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data.map((dynamic item) => Campus.fromJson(item)).toList();
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (_) {
      throw Exception("Failed to load data");
    }
  }

  static Future<List<Role>> getRoles({
    required school,
    required type,
  }) async {
    var url = Uri.parse("$grad$configSettings/roles/$school/$type");
    try {
      var response = await client.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data.map((dynamic item) => Role.fromJson(item)).toList();
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
