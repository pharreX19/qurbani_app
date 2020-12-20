import 'package:flutter/material.dart';

class NameSearchDelegate extends SearchDelegate{
  final List<dynamic> searchSuggestions;
  final List<dynamic> recentSearches = [
    {
      'name' : 'Test Name 0',
      'meaning': 'Test Meaning',
      'gender' : 'male',
      'is_favorited': false
    }
  ];
  Map<String, dynamic> selectedResult;

  NameSearchDelegate({this.searchSuggestions});

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(selectedResult['name']),
              Text(selectedResult['meaning'])
            ],
          )
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> suggestionList = [];
    query.isEmpty ? suggestionList = recentSearches : suggestionList.addAll(searchSuggestions.where((element) => element['name'].contains(query)));
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, int index){
        return ListTile(
          title: Text(suggestionList[index]['name']),
          onTap: (){
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );

  }
  
}