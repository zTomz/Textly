import 'package:flutter/material.dart';
import 'package:textly/widgets/big_detail_widget.dart';
import 'package:textly/widgets/detail_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  int wordsCount = 0;
  double averageSentenceLenght = 0;
  int sentenceCount = 0;

  Map<String, double> characters = {};

  //? Sum of Letters, Words, Sentence Starts
  int sumLetters = 0;
  int sumWords = 0;
  int sumSentenceStarts = 0;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 15),
              Row(
                children: [
                  Text("Textly", style: theme.textTheme.displayLarge),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: textController,
                onChanged: (value) {
                  // Words count
                  // ignore: no_leading_underscores_for_local_identifiers
                  List<String> _wordsCount = value.split(" ");

                  while (_wordsCount.remove("")) {
                    _wordsCount.remove("");
                  }

                  // Average sentence length
                  // ignore: no_leading_underscores_for_local_identifiers
                  int _sentenceCount = 0;
                  _sentenceCount += value.split("!").length - 1;
                  _sentenceCount += value.split("?").length - 1;
                  _sentenceCount += value.split(".").length - 1;

                  // Characters
                  // ignore: no_leading_underscores_for_local_identifiers
                  List<String> _chractersList = [];
                  characters = {};
                  for (int i = 0; i < value.length; i++) {
                    final character = value[i].toUpperCase();

                    if (character == " ") {
                      continue;
                    }

                    _chractersList.add(character);
                  }

                  _chractersList.sort();

                  characters.values.toList().sort();
                  for (final char in _chractersList) {
                    if (characters.containsKey(char)) {
                      characters[char] = characters[char]! + 1;
                    } else {
                      characters[char] = 1;
                    }
                  }

                  setState(() {
                    // Words count
                    wordsCount = _wordsCount.length;

                    // Average sentence length
                    sentenceCount = _sentenceCount;

                    // Characters
                    characters = characters;
                  });
                },
                maxLines: 6,
                minLines: null,
                decoration: InputDecoration(
                  labelText: "Your text",
                  suffix: IconButton.filledTonal(
                    onPressed: () {
                      setState(() {
                        textController.text = "";
                      });
                    },
                    tooltip: "Clear text",
                    icon: const Icon(Icons.clear_all_rounded),
                  ),
                ),
              ),
              if (textController.text != "")
                DetailWidget(
                  margin: const EdgeInsets.only(top: 30),
                  value: wordsCount.toString(),
                  title: "Words",
                ),
              if (textController.text != "")
                DetailWidget(
                  margin: const EdgeInsets.only(top: 15),
                  value: textController.text.length.toString(),
                  title: "Characters",
                ),
              if (textController.text != "")
                DetailWidget(
                  margin: const EdgeInsets.only(top: 15),
                  value: sentenceCount.toString(),
                  title: "Sentences",
                ),
              const SizedBox(height: 15),
              if (textController.text != "")
                BigDetailWidget(
                  title: "Characters",
                  itemBuilder: (context, index) => DetailWidget(
                    margin: const EdgeInsets.only(top: 10),
                    value: characters.entries.elementAt(index).key,
                    title: characters.entries.elementAt(index).value.toString(),
                  ),
                  itemCount: characters.length,
                  data: characters,
                ),
              if (textController.text != "") const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }
}
