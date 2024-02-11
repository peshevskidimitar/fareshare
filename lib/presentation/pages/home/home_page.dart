import 'package:fareshare/presentation/pages/auth/login_page.dart';
import 'package:fareshare/presentation/widgets/post/user_posts_list.dart';
import 'package:fareshare/service/blocs/app/app_bloc.dart';
import 'package:fareshare/service/blocs/post/post_bloc.dart';
import 'package:fareshare/presentation/pages/post/add_post_page.dart';
import 'package:fareshare/presentation/widgets/post/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _login() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _logout() {
    context.read<AppBloc>().add(const AppLogoutRequested());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(72, 40, 61, 1.0),
        title: Text(
          'Fare Share',
          style: GoogleFonts.sairaStencilOne(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
          ),
        ),
        actions: [
          user.isEmpty
              ? Row(
                  children: [
                    const Text(
                      'Најава',
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: _login,
                      icon: const Icon(Icons.login),
                      color: Colors.white,
                    ),
                  ],
                )
              : Row(
                  children: [
                    const Text(
                      'Одјава',
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: _logout,
                      icon: const Icon(Icons.logout),
                      color: Colors.white,
                    ),
                  ],
                )
        ],
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (BuildContext context, PostState state) {
          return switch (state) {
            PostsLoading() => const Center(child: CircularProgressIndicator()),
            PostsLoaded() => PostsList(posts: state.posts),
            _ => const Center(child: Text('Something went wrong.'))
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(164, 139, 156, 1.0),
        onPressed: () {
          if (user.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPostPage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }
        },
        child: const Icon(
          Icons.edit_outlined,
          color: Color.fromRGBO(76, 44, 60, 1.0),
        ),
      ),
    );
  }
}
