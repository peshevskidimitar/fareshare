import 'package:fareshare/domain/post.dart';
import 'package:fareshare/presentation/widgets/post/post_list_tile.dart';
import 'package:fareshare/presentation/widgets/post/user_post_list_tile.dart';
import 'package:fareshare/repository/reservation/reservation_repository.dart';
import 'package:fareshare/service/blocs/reservation/reservation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPostsList extends StatefulWidget {
  final List<Post> posts;

  const UserPostsList({super.key, required this.posts});

  @override
  State<UserPostsList> createState() => _UserPostsListState();
}

class _UserPostsListState extends State<UserPostsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Мои огласи'),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: widget.posts.length,
                (BuildContext context, int index) {
                  return BlocProvider(
                    create: (context) => ReservationBloc(
                        reservationRepository:
                            context.read<ReservationRepository>())
                      ..add(LoadReservations(widget.posts[index].id!)),
                    child: UserPostListTile(post: widget.posts[index]),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
