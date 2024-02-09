import 'package:fareshare/presentation/pages/auth/auth_page.dart';
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
  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthPage()),
                  );
                },
                icon: const Icon(Icons.login)),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPostPage()),
          );
        },
        child: const Icon(
          Icons.edit_outlined,
          color: Color.fromRGBO(76, 44, 60, 1.0),
        ),
      ),
    );
  }
}
