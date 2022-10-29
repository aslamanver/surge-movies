import 'package:flutter/material.dart';
import 'package:surge_movies/utils/extensions.dart';

class MessageListTileWidget extends StatelessWidget {
  final Exception? exception;

  const MessageListTileWidget({
    Key? key,
    this.exception,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF292B37).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Error: ${exception?.getUserMessage()}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
