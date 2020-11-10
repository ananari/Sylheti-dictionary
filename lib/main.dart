import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sylheti dictionary',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sylheti dictionary')
        ),
        body: Column(
          children: <Widget>[
            SearchBar(),
            Expanded(
                child: SearchResults()
            )
          ]
        )
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Search',
        ),
      )
    );
  }
}

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Welcome to the Sylheti dictionary!")
    );
  }
}
