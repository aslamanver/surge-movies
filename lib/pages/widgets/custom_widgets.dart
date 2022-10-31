import 'package:flutter/material.dart';
import 'package:surge_movies/data/configs/palette.dart';

offlineBanner() {
  return PreferredSize(
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
  );
}
