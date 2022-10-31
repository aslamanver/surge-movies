import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surge_movies/data/data.dart';
import 'package:surge_movies/pages/home/widgets/widgets.dart';
import 'package:surge_movies/pages/widgets/custom_widgets.dart';
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
    //
    movieProvider = Provider.of<MovieProvider>(context, listen: false);

    // Listen to internet connectivity changes
    movieProvider.activateConnectivityListener();

    // Call the HTTP/Database repository `getData()` method to retrieve the API data
    movieProvider.getData(page : 172);

    // Init the widget state
    super.initState();

    /* Listen to the ListView Scroll Controller to be notified when the user scrolled to 
    bottom in order to call the next page */
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          movieProvider.networkTaskStatus != NetworkTaskStatus.loading) {
        // Call the `getData()` method to retrieve next page data
        movieProvider.getData(page: movieProvider.page + 1);
      }
    });
  }

  @override
  void dispose() {
    // Dispose the ListView Scroll Controller
    scrollController.dispose();

    // Dispose the internet connectivity listener
    movieProvider.deactivateConnectivityListener();

    // Destroy the widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F111D),
      appBar: AppBar(
        bottom: Provider.of<MovieProvider>(context).isOffline
            ? offlineBanner()
            : null,
        title: Text(
          '(${Provider.of<MovieProvider>(context).movieList.length}) Top Rated Movies',
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
                  child: Text('DEV'),
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
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
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
