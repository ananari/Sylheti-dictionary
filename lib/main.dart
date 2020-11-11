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
          title: SearchToggle(),
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
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final _searchKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
      child: Form(
        key: _searchKey,
        child: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Search',
          ),
        )
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

class SearchToggle extends StatefulWidget {
  @override
  _SearchToggleState createState() => _SearchToggleState();
}

class _SearchToggleState extends State<SearchToggle> {
  String _title = "English → Sylheti";

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(_title, style: TextStyle(fontSize: 20.0, color: Colors.white)),
      onPressed: (() {
        String newValue = _title == "English → Sylheti" ? "Sylheti → English" : "English → Sylheti";
        setState(() {_title = newValue;});
      }),
    );
  }
}

