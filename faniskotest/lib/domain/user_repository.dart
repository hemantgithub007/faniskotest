import '../data/user_model.dart';

// Repository Interface
// Defines an abstract class with a method fetchUsers().
// Forces any implementation to provide user fetching logic.

abstract class UserRepository {
  Future<List<User>> fetchUsers();
}


