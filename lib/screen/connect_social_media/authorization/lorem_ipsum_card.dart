import 'dart:math';
import 'package:flutter/material.dart';

class LoremIpsumWidget extends StatelessWidget {
  final int wordCount;

  LoremIpsumWidget({required this.wordCount});

  @override
  Widget build(BuildContext context) {
    return Text(
      _generateLoremIpsum(),
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: 16.0,),
    );
  }

  String _generateLoremIpsum() {
    // Lorem Ipsum words
    List<String> loremIpsumWords = [
      "Lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing",
      "elit", "sed", "do", "eiusmod", "tempor", "incididunt", "ut", "labore",
      "et", "dolore", "magna", "aliqua"
    ];

    // Shuffle the words list
    loremIpsumWords.shuffle();

    // Generate Lorem Ipsum text with the specified word count
    List<String> loremIpsumList = [];
    int index = 0;
    while (loremIpsumList.length < wordCount) {
      loremIpsumList.add(loremIpsumWords[index]);
      index = (index + 1) % loremIpsumWords.length;
    }

    // Join the words into a single string
    return loremIpsumList.join(" ");
  }
}
