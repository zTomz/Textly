// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:textly/data.dart';
import 'package:textly/widgets/detail_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  int words = 0;
  List<List> letters = [];
  List<List> sentenceStarts = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: size.width * 0.925,
                height: size.height * 0.275,
                margin: const EdgeInsets.only(top: 70),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: GOLD,
                ),
                child: Center(
                  child: TextField(
                    onChanged: (String text) {
                      //! Calculate words
                      List<String> _words = text.split(" ");

                      while (_words.remove("")) {
                        _words.remove("");
                      }

                      setState(() {
                        words = _words.length + 1;
                      });
                      //! Calculate words

                      //! Calculate letters
                      List<String> _letters = text.split("");
                      List<String> _sortedLetters = _letters;
                      _sortedLetters.sort();

                      letters = [];

                      _sortedLetters.forEach((letter) {
                        bool run = true;

                        letters.forEach((letterList) {
                          if (letter == letterList[0]) {
                            setState(() {
                              letterList[1] = letterList[1] + 1;
                            });
                            run = false;
                          }
                        });

                        if (run) {
                          setState(() {
                            letters.add([letter, 1]);
                          });
                        }
                      });

                      //! Calculate sentece starts
                      sentenceStarts = [];

                      int _spacesAfterPoint = 0;
                      String _newWord = "";
                      String _letterBefore = "";
                      List<String> _countStartWordsList = [];

                      text.split("").forEach((letter) {
                        if (letter == "." || letter == "?" || letter == "!") {
                          _countStartWordsList.add(_newWord);
                          _newWord = "";
                          _spacesAfterPoint = 0;
                        }

                        if (letter == " ") {
                          _spacesAfterPoint += 1;
                        }

                        if (_spacesAfterPoint == 0 && _letterBefore == "." && letter != "?" && letter != "!") {
                          _spacesAfterPoint += 1;
                        }

                        if (_spacesAfterPoint == 0 && _letterBefore == "") {
                          _spacesAfterPoint += 1;
                        }

                        if (letter != "." && letter != "?" && letter != "!" &&
                            _spacesAfterPoint <= 1 &&
                            letter != " ") {
                          _newWord += letter;
                          print("New word: $_newWord");
                        }

                        _letterBefore = letter;
                      });

                      print("Sentence Starts: $_countStartWordsList");

                      _countStartWordsList.sort();
                      print("Sentence Starts: $_countStartWordsList");

                      _countStartWordsList.forEach((sortWord) {
                        bool run = true;

                        sentenceStarts.forEach((word) {
                          if (sortWord == word[0]) {
                            setState(() {
                              word[1] = word[1] + 1;
                            });
                            run = false;
                          }
                        });

                        if (run) {
                          setState(() {
                            sentenceStarts.add([sortWord, 1]);
                          });
                        }
                      });

                      print("Sentence Starts: $sentenceStarts");
                    },
                    controller: textController,
                    maxLines: 9,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Your text here...",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              DetailWidget(
                count: words.toString(),
                title: "Words",
              ),
              DetailWidget(
                count: textController.text.length.toString(),
                title: "Letters",
              ),
              const SizedBox(height: 10),
              Container(
                height: 300,
                width: size.width * 0.925,
                decoration: BoxDecoration(
                  color: GOLD,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: letters
                        .map(
                          (value) => Container(
                            height: 60,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),
                              border: Border.all(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                width: 6,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: (size.width * 0.925 - 20) * 0.25,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        width: 6,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      value[0],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Center(
                                  child: Center(
                                    child: Text(
                                      value[1].toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ))
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }
}
