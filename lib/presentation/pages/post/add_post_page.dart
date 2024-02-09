import 'package:fareshare/presentation/widgets/post/add_post_form.dart';
import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 246, 244, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(254, 246, 244, 1.0),
        title: const Text('Нов оглас'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: AddPostForm(),
      ),
    );
  }
}
