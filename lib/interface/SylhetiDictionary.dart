import 'package:flutter/material.dart';
import './SearchBar.dart';
import './SearchResults.dart';
import './SearchToggle.dart';

class SylhetiDictionary extends StatefulWidget {
  @override
  _SylhetiDictionaryState createState() => _SylhetiDictionaryState();
}

class _SylhetiDictionaryState extends State<SylhetiDictionary> {
  bool isEnglish = false;
  String searchTerm;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SearchToggle(
              isEnglish: isEnglish,
              toggleSearch: () {
                setState(() {
                  isEnglish = !isEnglish;
                });
              }
          ),
        ),
        body: Column(
            children: <Widget>[
              SearchBar(
                setTerm: (String term) {
                  setState(() {
                    searchTerm = term;
                  });
                }
              ),
              Expanded(
                  child: SearchResults(searchTerm: searchTerm)
              )
            ]
        )
    );
  }
}