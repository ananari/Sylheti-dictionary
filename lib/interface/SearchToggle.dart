import 'package:flutter/material.dart';

class SearchToggle extends StatelessWidget {
  final bool isEnglish;
  final VoidCallback toggleSearch;

  SearchToggle({@required this.isEnglish, this.toggleSearch});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(isEnglish ? "English → Sylheti" : "Sylheti → English", style: TextStyle(fontSize: 20.0, color: Colors.white)),
      onPressed: () => toggleSearch(),
    );
  }
}