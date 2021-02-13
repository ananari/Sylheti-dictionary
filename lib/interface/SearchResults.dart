import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SearchResults extends StatefulWidget {

  final String searchTerm;

  SearchResults({@required this.searchTerm});

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
          return Center(
              child: Text("hello")
          );
        }
    );
  }
}