import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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

class SylhetiDictionary extends StatefulWidget {
  @override
  _SylhetiDictionaryState createState() => _SylhetiDictionaryState();
}

class _SylhetiDictionaryState extends State<SylhetiDictionary> {
  bool isEnglish = false;


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
          SearchBar(),
          Expanded(
            child: SearchResults()
          )
        ]
      )
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
