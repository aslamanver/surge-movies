import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:surge_movies/data/models/movie.dart';
import 'package:surge_movies/pages/home/widgets/vote_indicator.dart';
import 'package:surge_movies/secrets/secrets.dart' as secrets;

class MovieListTile extends StatelessWidget {
  final int index;
  final Movie movie;

  const MovieListTile({
    super.key,
    required this.movie,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xFF292B37),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF292B37).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
            )
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  // child: FutureBuilder(
                  //   future: DefaultCacheManager().getFileFromCache(
                  //     '${secrets.imageEndpoint}${movie.posterPath}',
                  //   ),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData && snapshot.data != null) {
                  //       return Image.file(snapshot.data!.file);
                  //     } else {
                  //       return Image.asset('placeholder.png');
                  //       // return CachedNetworkImage(
                  //       //   errorWidget: (context, url, error) =>
                  //       //       Image.asset('placeholder.png'),
                  //       //   placeholder: (context, url) =>
                  //       //       Image.asset('placeholder.png'),
                  //       //   fadeInDuration: const Duration(milliseconds: 30),
                  //       //   imageUrl: '${secrets.imageEndpoint}${movie.posterPath}',
                  //       // );
                  //     }
                  //   },
                  // ),
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) =>
                        Image.asset('placeholder.png'),
                    placeholder: (context, url) =>
                        Image.asset('placeholder.png'),
                    fadeInDuration: const Duration(milliseconds: 30),
                    imageUrl: '${secrets.imageEndpoint}${movie.posterPath}',
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, bottom: 5),
                      child: ProgressIndicatorButton(
                        percentage: (movie.voteAverage * 10).toInt(),
                      ),
                    )
                  ],
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${index + 1} ${movie.originalTitle}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '(${movie.title})',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '${movie.releaseDate} (${movie.originalLanguage}) . ',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text(
                            movie.adult ? 'R' : 'All',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      movie.overview,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
