import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surge_movies/data/data.dart';
import 'package:surge_movies/pages/home/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  late MovieProvider movieProvider;
  final scrollController = ScrollController();

  @override
  void initState() {
    movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movieProvider.getData(localSource: false);
    super.initState();
    // scrollController.addListener(() {
    //   if (scrollController.position.maxScrollExtent ==
    //           scrollController.offset &&
    //       movieProvider.networkTaskStatus != NetworkTaskStatus.loading) {
    //     movieProvider.getData(page: movieProvider.page + 1);
    //   }
    // });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F111D),
      appBar: AppBar(
        title: Text(
          'Top Rated Movies ${Provider.of<MovieProvider>(context).movieList.length}',
        ),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, item, child) {
          return ListView.builder(
            controller: scrollController,
            itemCount: movieProvider.movieList.length + 1,
            itemBuilder: (context, index) {
              if (index == movieProvider.movieList.length) {
                if ([
                  NetworkTaskStatus.loading,
                  NetworkTaskStatus.success,
                ].contains(movieProvider.networkTaskStatus)) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return MessageListTileWidget(
                    exception: movieProvider.exception,
                  );
                }
              }
              return MovieListTile(
                index: index,
                movie: movieProvider.movieList[index],
              );
            },
          );
        },
      ),
    );
  }
}
