import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';


// Calls userRepository.fetchUsers() inside an event listener.

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await userRepository.fetchUsers();
        emit(UserLoaded(users));
      } catch (_) {
        emit(UserError());
      }
    });
  }
}

