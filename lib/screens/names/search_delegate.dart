import 'package:flutter/material.dart';

class Search extends SearchDelegate{
  final List<String> searchSuggestions;
  final List<String> recentSearches = ['Search One', 'Search two'];
  String selectedResult;

  Search({this.searchSuggestions});

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(icon: Icon(Icons.close), onPressed: (){
        query = "";
      },)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
      Navigator.pop(context);
    },);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
          child: Text(selectedResult)
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty ? suggestionList = recentSearches : suggestionList.addAll(searchSuggestions.where((element) => element.contains(query)));
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, int index){
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: (){
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );

  }
  
}