import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_constants.dart';

class WebService {
  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse(ApiConstants.usersEndpoint));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load users");
    }
  }
}
