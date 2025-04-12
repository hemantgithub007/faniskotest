import 'package:faniskotest/presentation/bloc/user_event.dart';
import 'package:faniskotest/web_services/web_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/user_repository_impl.dart';
import 'presentation/bloc/user_bloc.dart';
import 'presentation/screens/user_list_screen.dart';
import 'theme/theme_cubit.dart';


void main() {
  final webService = WebService();
  final userRepository = UserRepositoryImpl(webService);

  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepositoryImpl userRepository;

  MyApp({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc(userRepository)..add(FetchUsers())),
        BlocProvider(create: (context) => ThemeCubit()),  // Provides ThemeCubit
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: UserListScreen(),
          );
        },
      ),
    );
  }
}

