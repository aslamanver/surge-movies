import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surge_movies/data/data.dart';
import 'package:surge_movies/pages/home/widgets/widgets.dart';
import 'package:surge_movies/utils/extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  late MovieProvider movieProvider;
  final scrollController = ScrollController();
  Timer? timer;

  @override
  void initState() {
    movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movieProvider.activateConnectivityListener();
    movieProvider.getData();
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          movieProvider.networkTaskStatus != NetworkTaskStatus.loading) {
        movieProvider.getData(page: movieProvider.page + 1);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    movieProvider.deactivateConnectivityListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F111D),
      appBar: AppBar(
        bottom: Provider.of<MovieProvider>(context).isOffline
            ? PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Container(
                    decoration: BoxDecoration(
                      color: ColorPalette.secondary,
                      boxShadow: [
                        BoxShadow(
                          color: ColorPalette.primary.withOpacity(0.8),
                          spreadRadius: 2,
                          blurRadius: 6,
                        )
                      ],
                    ),
                    height: 80,
                    child: const Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'Please check your internet connection !',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    )),
              )
            : null,
        title: Text(
          'Top Rated Movies ${Provider.of<MovieProvider>(context).movieList.length}',
        ),
        leading: const Icon(
          Icons.theaters,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: GestureDetector(
              onTap: () {
                movieProvider.reset();
                movieProvider.getData();
              },
              child: const Icon(
                Icons.refresh,
                size: 26.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: PopupMenuButton<int>(
              onSelected: (item) {
                if (item == 1) {
                  if (timer != null && timer!.isActive) {
                    timer?.cancel();
                  } else {
                    timer = Timer.periodic(const Duration(milliseconds: 200),
                        (timer) {
                      scrollController
                          .jumpTo(scrollController.position.maxScrollExtent);
                    });
                  }
                  return;
                }
                movieProvider.clearLocalData();
                movieProvider.getData();
              },
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text('Clear downloaded data'),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('Stop Timer'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Consumer<MovieProvider>(
        builder: (context, item, child) {
          return RefreshIndicator(
            onRefresh: () {
              movieProvider.reset();
              return movieProvider.getData();
            },
            child: ListView.builder(
              controller: scrollController,
              itemCount: movieProvider.movieList.length + 1,
              itemBuilder: (context, index) {
                if (index == movieProvider.movieList.length) {
                  if ([
                    NetworkTaskStatus.loading,
                    NetworkTaskStatus.success,
                  ].contains(movieProvider.networkTaskStatus)) {
                    if (movieProvider.isLocalData) {
                      return const MessageListTileWidget(
                        message: 'That\'s all',
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  } else {
                    return MessageListTileWidget(
                      message: movieProvider.exception?.getUserMessage(),
                    );
                  }
                }
                return MovieListTile(
                  index: index,
                  movie: movieProvider.movieList[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
