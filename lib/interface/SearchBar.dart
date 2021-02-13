import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function(String) setTerm;
  SearchBar({this.setTerm});

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
    return Form(
        key: _searchKey,
        child: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Search',
          ),
        )
    );
  }
}