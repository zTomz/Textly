// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_function_literals_in_foreach_calls, deprecated_member_use

import 'package:flutter/material.dart';
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
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40, bottom: 15),
                width: size.width * 0.85,
                child: Text("Textly", style: theme.textTheme.headline1),
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

                        if (_spacesAfterPoint == 0 &&
                            _letterBefore == "." &&
                            letter != "?" &&
                            letter != "!") {
                          _spacesAfterPoint += 1;
                        }

                        if (_spacesAfterPoint == 0 && _letterBefore == "") {
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
                        Text("to get informations!",
                            style: theme.textTheme.headline1),
                      ],
                    ),
                  ),
                ),
              if (textController.text != "") const SizedBox(height: 25),
              if (textController.text != "")
                DetailWidget(
                  count: words.toString(),
                  title: "Words",
                ),
              if (textController.text != "")
                DetailWidget(
                  count: textController.text.length.toString(),
                  title: "Letters",
                ),
              if (textController.text != "") const SizedBox(height: 20),
              if (textController.text != "")
                Container(
                  height: 300,
                  width: size.width * 0.85,
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: letters
                          .map(
                            (value) => Container(
                              height: 60,
                              margin: const EdgeInsets.only(
                                  top: 20, left: 10, right: 20),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.accentColor,
                                    offset: const Offset(9, 9),
                                  ),
                                ],
                                border: Border.all(
                                    width: 9, color: theme.accentColor),
                                color: theme.primaryColor,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.85 * 0.3,
                                    height: 70,
                                    child: Center(
                                      child: Text(
                                        value[1].toString(),
                                        style: theme.textTheme.bodyText2,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 10,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: theme.accentColor,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        value[0].toString(),
                                        style: theme.textTheme.bodyText2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              if (textController.text != "") const SizedBox(height: 20),
              if (textController.text != "")
                Container(
                  height: 300,
                  width: size.width * 0.85,
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: sentenceStarts
                          .map(
                            (value) => Container(
                              height: 60,
                              margin: const EdgeInsets.only(
                                  top: 20, left: 10, right: 20),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.accentColor,
                                    offset: const Offset(9, 9),
                                  ),
                                ],
                                border: Border.all(
                                    width: 9, color: theme.accentColor),
                                color: theme.primaryColor,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.85 * 0.3,
                                    height: 70,
                                    child: Center(
                                      child: Text(
                                        value[1].toString(),
                                        style: theme.textTheme.bodyText2,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 10,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: theme.accentColor,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        value[0].toString(),
                                        style: theme.textTheme.bodyText2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              if (textController.text != "") const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }
}
