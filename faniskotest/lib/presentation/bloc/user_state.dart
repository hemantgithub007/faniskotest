import '../../data/user_model.dart';


abstract class UserState {}

// UserInitial → Default state before fetching starts.
class UserInitial extends UserState {}

// UserLoading → Shows loading spinner while fetching.
class UserLoading extends UserState {}

// UserLoaded(users) → Holds the list of users after a successful fetch.
class UserLoaded extends UserState {
  final List<User> users;
  UserLoaded(this.users);
}

// Shows an error message if fetching fails
class UserError extends UserState {}


