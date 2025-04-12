import 'package:http/http.dart' as http;
import 'dart:convert';
import '../domain/user_repository.dart';
import '../web_services/web_service.dart';
import 'user_model.dart';


// Repository Implementation)
// Implements UserRepository and defines fetchUsers().
// Uses http package to call API https://jsonplaceholder.typicode.com/users.
// Parses JSON response into a List of User objects.
//
// class UserRepositoryImpl implements UserRepository {
//   @override
//   Future<List<User>> fetchUsers() async {
//     final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
//     if (response.statusCode == 200) {
//       List<dynamic> jsonData = json.decode(response.body);
//       return jsonData.map((user) => User.fromJson(user)).toList();
//     } else {
//       throw Exception("Failed to load users");
//     }
//   }
// }


class UserRepositoryImpl implements UserRepository {
  final WebService webService;

  UserRepositoryImpl(this.webService);

  @override
  Future<List<User>> fetchUsers() async {
    final jsonData = await webService.fetchUsers();
    return jsonData.map((user) => User.fromJson(user)).toList();
  }
}