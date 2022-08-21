// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_function_literals_in_foreach_calls, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textly/model/setting.dart';
import 'package:textly/services/boxes.dart';
import 'package:textly/settings.dart';
import 'package:textly/widgets/detail_list_view.dart';
import 'package:textly/widgets/detail_widget.dart';
import 'package:textly/widgets/icon_button.dart';
import 'package:textly/widgets/settings_window.dart';
import 'package:textly/widgets/two_information_box.dart';

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
  List<int> sentenceLenghts = [];

  //? Sum of Letters, Words, Sentence Starts
  int sumLetters = 0;
  int sumWords = 0;
  int sumSentenceStarts = 0;

  bool settingsWindow = false;

  //* To add new settings:
  // Box settingsBox = Boxes.getSettingsBox();

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
                            //* To add new setting:
                            // settings
                            //     .forEach((setting) => settingsBox.add(setting));
                            // settingsBox.clear();
                            // print(settingsBox.values);
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
                            readOnly: settingsWindow,
                            onChanged: (String text) {
                              sumLetters = 0;
                              sumWords = 0;
                              sumSentenceStarts = 0;

                              //! Calculate words
                              List<String> _wordsCount = text.split(" ");

                              while (_wordsCount.remove("")) {
                                _wordsCount.remove("");
                              }

                              //! Calculate average sentence lenght
                              //* Check if sentence lenght is wanted
                              if (settings[2].status) {
                                int _sentenceLenght = 0;
                                sentenceLenghts = [];

                                for (String c in text.split("")) {
                                  if (c == "." || c == "?" || c == "!") {
                                    sentenceLenghts.add(_sentenceLenght);
                                    _sentenceLenght = 0;
                                    continue;
                                  }
                                  _sentenceLenght += 1;
                                }
                              }

                              //! Calculate letters
                              String _text = text;
                              letters = [];

                              //* Check if spaces are to count
                              if (settings[3].status == false) {
                                _text = _text.replaceAll(" ", "");
                              }
                              //* Check if lower case or not
                              if (settings[4].status == false) {
                                _text = _text.toLowerCase();
                              }
                              List<String> _lettersForWord = _text.split("");

                              //* Check if text is to sort
                              if (settings[5].status) {
                                _lettersForWord.sort();
                              }

                              List<List> _lettersToOverride = [];

                              _lettersForWord.forEach((letter) {
                                bool run = true;

                                _lettersToOverride.forEach((letterList) {
                                  if (letter == letterList[0]) {
                                    letterList[1] = letterList[1] + 1;

                                    run = false;
                                  }
                                });

                                if (run) {
                                  _lettersToOverride.add([letter, 1]);
                                }

                                sumLetters += 1;
                              });

                              //! Calculate words
                              _text = text;
                              words = [];

                              //? Removing all sentence letters
                              _text = _text.replaceAll(".", " ");
                              _text = _text.replaceAll("?", " ");
                              _text = _text.replaceAll("!", " ");

                              //* Check if all in lowercase or not
                              if (settings[6].status == false) {
                                _text = _text.toLowerCase();
                              }

                              List<String> _words = _text.split(" ");

                              //* Check if words have to be sorted
                              if (settings[7].status) {
                                _words.sort();
                              }

                              List<List> _wordsToOverride = [];

                              for (String word in _words) {
                                if (word.contains(" ") || word == "") {
                                  continue;
                                }

                                for (List wordsList in _wordsToOverride) {
                                  if (word == wordsList[0]) {
                                    wordsList[1] = wordsList[1] + 1;
                                    sumWords += 1;
                                    continue;
                                  }
                                }

                                _wordsToOverride.add([word, 1]);
                                sumWords += 1;
                              }

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

                              if (settings[8].status) {
                                _countStartWordsList.sort();
                              }

                              List<List> _sentenceStartsToOverride = [];

                              _countStartWordsList.forEach((sortWord) {
                                bool run = true;

                                _sentenceStartsToOverride.forEach((word) {
                                  if (sortWord == word[0]) {
                                    word[1] = word[1] + 1;

                                    run = false;
                                  }
                                });

                                if (run) {
                                  _sentenceStartsToOverride.add([sortWord, 1]);
                                }

                                sumSentenceStarts += 1;
                              });

                              //! Update every widget only here, for better performance
                              setState(() {
                                //* Words count
                                wordsCount = _wordsCount.length;
                                //* Letters
                                letters = _lettersToOverride;
                                //* Words
                                words = _wordsToOverride;
                                //* Sentence Starts
                                sentenceStarts = _sentenceStartsToOverride;
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
                              icon:
                                  Icon(Icons.delete, color: theme.accentColor),
                              onTap: () {
                                setState(() {
                                  textController.text = "";
                                });
                              },
                            ),
                          ),
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
                  if (textController.text != "" && settings[2].status)
                    const SizedBox(height: 20),
                  if (textController.text != "" && settings[2].status)
                    TwoInformationBox(
                      title: "Sentence lenghts",
                      info1: [
                        calculateAverrage(sentenceLenghts).toStringAsFixed(2),
                        "Average length"
                      ],
                      info2: [
                        getLongestSentence(sentenceLenghts).toString(),
                        "Longest"
                      ],
                    ),
                  if (textController.text != "") const SizedBox(height: 20),
                  if (textController.text != "")
                    DetailListView(
                      title: "Letters",
                      list: letters,
                      sum: sumLetters,
                    ),
                  if (textController.text != "") const SizedBox(height: 20),
                  if (textController.text != "")
                    DetailListView(
                      title: "Words",
                      list: words,
                      sum: sumWords,
                    ),
                  if (textController.text != "") const SizedBox(height: 20),
                  if (textController.text != "")
                    DetailListView(
                      title: "Sentence starts",
                      list: sentenceStarts,
                      sum: sumSentenceStarts,
                    ),
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

  double calculateAverrage(List<int> list) {
    int sum = 0;
    for (int num in list) {
      sum += num;
    }

    return sum / list.length;
  }

  int getLongestSentence(List<int> list) {
    int highestNum = 0;

    for (int num in list) {
      if (num > highestNum) {
        highestNum = num;
      }
    }

    return highestNum;
  }
}
