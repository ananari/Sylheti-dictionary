import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './interface/SylhetiDictionary.dart';


void main() {


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override


  Widget build(BuildContext context) {

    final HttpLink httpLink = HttpLink("https://sylheti-backend.gigalixirapp.com/api/graphiql");
    final Link link = httpLink;
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(),
        // The default store is the InMemoryStore, which does NOT persist to disk
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Sylheti dictionary',
        home: SylhetiDictionary(),
      )
    );
  }
}



