import 'package:flutter/material.dart';
import 'package:jokes_app/joke.dart';

class DetailJokePage extends StatelessWidget {
  final Joke? joke;
  final bool isFromPushedPage;
  const DetailJokePage(
      {super.key, required this.joke, required this.isFromPushedPage});

  @override
  Widget build(BuildContext context) {
    final screenOrientation = MediaQuery.orientationOf(context);
    final screenSize = MediaQuery.sizeOf(context).shortestSide;
    if (screenOrientation == Orientation.portrait && screenSize < 600) {
    } else {
      if (isFromPushedPage) {
        Future.delayed(const Duration(microseconds: 10), () {
          Navigator.pop(context);
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text(joke?.type ?? "Type belum dipilih"),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(joke?.setup ?? "Joke belum dipilih"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(joke?.punchline ?? "Tidak ada punchline"),
          )
        ],
      )),
    );
  }
}
