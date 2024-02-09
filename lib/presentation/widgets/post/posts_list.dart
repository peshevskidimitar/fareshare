import 'package:fareshare/service/blocs/reservation/reservation_bloc.dart';
import 'package:fareshare/domain/post.dart';
import 'package:fareshare/presentation/widgets/post/post_list_tile.dart';
import 'package:fareshare/repository/reservation/reservation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsList extends StatefulWidget {
  final List<Post> posts;

  const PostsList({super.key, required this.posts});

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final SearchController _searchController = SearchController();
  late List<Post> _filteredPosts;

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredPosts = widget.posts;
      });
    } else {
      setState(() {
        _filteredPosts = widget.posts.where((post) {
          String departureCity = post.departureCity.toLowerCase();
          String arrivalCity = post.arrivalCity.toLowerCase();
          return departureCity.contains(query.toLowerCase()) ||
              arrivalCity.contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  void queryListener() {
    search(_searchController.text);
  }

  @override
  void initState() {
    super.initState();
    _filteredPosts = widget.posts;
    _searchController.addListener(queryListener);
  }

  @override
  void dispose() {
    _searchController.removeListener(queryListener);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          floating: true,
          flexibleSpace: Container(
            padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
            child: SearchBar(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(164, 139, 156, 1.0)),
              controller: _searchController,
              hintText: 'Пребарај по град...',
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
        // Next, create a SliverList
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: _filteredPosts.length,
            (BuildContext context, int index) {
              return BlocProvider(
                create: (context) => ReservationBloc(
                    reservationRepository:
                        context.read<ReservationRepository>())
                  ..add(LoadReservations(_filteredPosts[index].id!)),
                child: PostListTile(post: _filteredPosts[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
