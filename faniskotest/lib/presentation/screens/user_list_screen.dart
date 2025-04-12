import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme/theme_cubit.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_state.dart';
//
// class UserListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Users'),
//         actions: [
//           // Toggle Button for Dark/Light Mode
//           IconButton(
//             icon: Icon(Icons.brightness_6),
//             onPressed: () {
//               context.read<ThemeCubit>().toggleTheme();
//             },
//           ),
//         ],
//       ),
//       body: BlocBuilder<UserBloc, UserState>(
//         builder: (context, state) {
//           if (state is UserLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is UserError) {
//             return Center(child: Text("Error loading users"));
//           } else if (state is UserLoaded) {
//             return ListView.builder(
//               itemCount: state.users.length,
//               itemBuilder: (context, index) {
//                 final user = state.users[index];
//                 return ListTile(title: Text(user.name), subtitle: Text("ID: ${user.id}"));
//               },
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }

class UserListScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Custom Search Bar
          CustomSearchBar(controller: _searchController),

          // User List
          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is UserError) {
                  return Center(child: Text("Error loading users"));
                } else if (state is UserLoaded) {
                  final usersToShow = state.filteredUsers;

                  if (usersToShow.isEmpty && state.searchQuery.isNotEmpty) {
                    return Center(child: Text("No results found"));
                  }

                  return ListView.builder(
                    itemCount: usersToShow.length,
                    itemBuilder: (context, index) {
                      final user = usersToShow[index];

                      return ListTile(
                        title: _highlightText(user.name, state.searchQuery),
                        subtitle: Text("ID: ${user.id}"),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function to highlight search query in the name
  Widget _highlightText(String name, String query) {
    if (query.isEmpty) return Text(name);

    final regex = RegExp(query, caseSensitive: false);
    final matches = regex.allMatches(name);

    if (matches.isEmpty) return Text(name);

    List<TextSpan> spans = [];
    int start = 0;

    for (var match in matches) {
      spans.add(TextSpan(text: name.substring(start, match.start)));
      spans.add(TextSpan(
        text: name.substring(match.start, match.end),
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
      ));
      start = match.end;
    }

    spans.add(TextSpan(text: name.substring(start)));

    return RichText(text: TextSpan(style: TextStyle(color: Colors.black), children: spans));
  }
}