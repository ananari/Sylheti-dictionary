import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SearchResults extends StatelessWidget {

  final String searchTerm;
  SearchResults({@required this.searchTerm});
  final String allWords =
  """{
    words {
      ipa
    }
  }""";

  @override
  Widget build(BuildContext context) {
    if(true){
      return Query(
          options: QueryOptions(
              document: gql(allWords)
          ),
          builder: (QueryResult result,
              { VoidCallback refetch, FetchMore fetchMore }) {
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
}
