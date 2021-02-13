import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SearchResults extends StatefulWidget {

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {

  String allWords = """
  {
  words {
    ipa
  }
}""";

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            document: gql(allWords)
        ),
        builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return Text('Loading');
          }

          List words = result.data['words'];
          print(words);
          return Center(
              child: Text("hewwo")
          );
        }
    );
  }
}