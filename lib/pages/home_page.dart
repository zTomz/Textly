// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_function_literals_in_foreach_calls, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:textly/widgets/detail_list_view.dart';
import 'package:textly/widgets/detail_widget.dart';
import 'package:textly/widgets/icon_button.dart';
import 'package:textly/widgets/settings_window.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  int wordsCount = 0;
  List<List> letters = [];
  List<List> words = [];
  List<List> sentenceStarts = [];

  bool settingsWindow = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 15),
                    width: size.width * 0.85,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Textly", style: theme.textTheme.headline1),
                        RetroIconButton(
                          tooltip: "Settings",
                          icon: Icon(Icons.settings, color: theme.accentColor),
                          onTap: () {
                            setState(() {
                              settingsWindow = true;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 0.85,
                    height: size.height * 0.275,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: theme.accentColor,
                          offset: const Offset(9, 9),
                        ),
                      ],
                      border: Border.all(width: 9, color: theme.accentColor),
                      color: theme.primaryColor,
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          TextField(
                            onChanged: (String text) {
                              //! Calculate words
                              List<String> _wordsCount = text.split(" ");

                              while (_wordsCount.remove("")) {
                                _wordsCount.remove("");
                              }

                              setState(() {
                                wordsCount = _wordsCount.length;
                              });
                              //! Calculate words

                              //! Calculate letters
                              List<String> _letters = text
                                  .toLowerCase()
                                  .replaceAll(" ", "")
                                  .split("");

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

                              //! Calculate words
                              List<String> _words = text.split(" ");
                              List<String> _sortedWords = _words;
                              _sortedLetters.sort();

                              words = [];

                              _sortedWords.forEach((word) {
                                bool run = true;

                                words.forEach((wordsList) {
                                  if (word == wordsList[0]) {
                                    setState(() {
                                      wordsList[1] = wordsList[1] + 1;
                                    });
                                    run = false;
                                  }
                                });

                                if (run) {
                                  setState(() {
                                    words.add([word, 1]);
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
                                if (letter == "." ||
                                    letter == "?" ||
                                    letter == "!") {
                                  _countStartWordsList.add(_newWord);
                                  _newWord = "";
                                  _spacesAfterPoint = 0;
                                }

                                if (letter == " ") {
                                  _spacesAfterPoint += 1;
                                }

                                if (_spacesAfterPoint == 0 &&
                                    _letterBefore == "." &&
                                    letter != "?" &&
                                    letter != "!") {
                                  _spacesAfterPoint += 1;
                                }

                                if (_spacesAfterPoint == 0 &&
                                    _letterBefore == "") {
                                  _spacesAfterPoint += 1;
                                }

                                if (letter != "." &&
                                    letter != "?" &&
                                    letter != "!" &&
                                    _spacesAfterPoint <= 1 &&
                                    letter != " ") {
                                  _newWord += letter;
                                }

                                _letterBefore = letter;
                              });

                              _countStartWordsList.sort();

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
                            },
                            controller: textController,
                            maxLines: 9,
                            style: theme.textTheme.bodyText2!
                                .copyWith(fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Your text here...",
                              hintStyle: theme.textTheme.bodyText1,
                            ),
                          ),
                          Positioned(
                              bottom: 12,
                              right: 4,
                              child: RetroIconButton(
                                tooltip: "Clear text",
                                icon: Icon(Icons.delete,
                                    color: theme.accentColor),
                                onTap: () {
                                  setState(() {
                                    textController.text = "";
                                  });
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                  if (textController.text == "")
                    Container(
                      margin: const EdgeInsets.only(top: 200),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Type some text",
                                style: theme.textTheme.headline1),
                            Text("to get information!",
                                style: theme.textTheme.headline1),
                          ],
                        ),
                      ),
                    ),
                  if (textController.text != "") const SizedBox(height: 25),
                  if (textController.text != "")
                    DetailWidget(
                      count: wordsCount.toString(),
                      title: "Words",
                    ),
                  if (textController.text != "")
                    DetailWidget(
                      count: textController.text.length.toString(),
                      title: "Characters",
                    ),
                  if (textController.text != "") const SizedBox(height: 20),
                  if (textController.text != "")
                    DetailListView(title: "Letters", list: letters),
                  if (textController.text != "") const SizedBox(height: 20),
                  if (textController.text != "")
                    DetailListView(title: "Words", list: words),
                  if (textController.text != "") const SizedBox(height: 20),
                  if (textController.text != "")
                    DetailListView(
                        title: "Sentence starts", list: sentenceStarts),
                  if (textController.text != "") const SizedBox(height: 90),
                ],
              ),
            ),
          ),
          if (settingsWindow)
            SettingsWindow(
              closeWindowFunc: () {
                setState(() {
                  settingsWindow = false;
                });
              },
            ),
        ],
      ),
    );
  }
}
