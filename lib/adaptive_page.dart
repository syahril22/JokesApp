import 'package:flutter/material.dart';
import 'package:jokes_app/detail_joke.dart';
import 'package:jokes_app/joke.dart';

class AdaptivePage extends StatefulWidget {
  const AdaptivePage({super.key});

  @override
  State<AdaptivePage> createState() => _AdaptivePageState();
}

class _AdaptivePageState extends State<AdaptivePage> {
  Joke? jokeChoices;
  @override
  Widget build(BuildContext context) {
    late Widget content;
    final screenOrientation = MediaQuery.orientationOf(context);
    final screenSize = MediaQuery.sizeOf(context).shortestSide;
    if (screenOrientation == Orientation.portrait && screenSize < 600) {
      // Tampilan Hp
      content = buildNoTablet();
    } else {
      // Tampilan Tablet
      content = buildTablet();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke App'),
      ),
      body: content,
    );
  }

  Widget buildNoTablet() {
    return ListJoke(chooseJokeCallback: (value) {
      final route = MaterialPageRoute(
        builder: (context) => DetailJokePage(
          joke: value,
          isFromPushedPage: true,
        ),
      );
      Navigator.push(context, route);
    });
  }

  Widget buildTablet() {
    return Row(
      children: [
        // list
        Flexible(
          child: ListJoke(
            joke: jokeChoices,
            chooseJokeCallback: (value) {
              setState(() {
                jokeChoices = value;
              });
            },
          ),
        ),

        // detail joke
        Flexible(
          child: DetailJokePage(
            joke: jokeChoices,
            isFromPushedPage: false,
          ),
        ),
      ],
    );
  }
}

class ListJoke extends StatelessWidget {
  final Joke? joke;
  final ValueChanged<Joke> chooseJokeCallback;
  const ListJoke({super.key, required this.chooseJokeCallback, this.joke});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jokesList.length,
      itemBuilder: ((context, index) {
        final joke = jokesList[index];
        return ListTile(
          title: Text(joke.setup),
          onTap: () {
            // final route = MaterialPageRoute(
            //     builder: (context) => DetailJokePage(joke: joke));
            // Navigator.push(context, route);
            chooseJokeCallback(joke);
          },
          selected: joke == this.joke,
        );
      }),
    );
  }
}
