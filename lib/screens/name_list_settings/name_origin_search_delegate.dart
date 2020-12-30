import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/controllers/name_settings_controller.dart';
import 'package:qurbani/providers/name_validator_provider.dart';

class NameOriginSearchDelegate extends SearchDelegate{
  final List<dynamic> searchSuggestions;
  final List<dynamic> recentSearches = ['Arabic', 'Hebrew', 'Turkish'];
  final NameValidationProvider validationService;
  String selectedResult;

  NameOriginSearchDelegate({this.searchSuggestions, this.validationService});

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
                Text(selectedResult)
              ],
            )
        )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> suggestionList = [];
    query.isEmpty ? suggestionList = recentSearches : suggestionList.addAll(searchSuggestions.where((element) => element.contains(query)));
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, int index){
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: (){
            selectedResult = suggestionList[index];
            validationService.onNameOriginChanged(selectedResult);
            // Get.find<NameSettingsController>().origin.value = selectedResult;
            Navigator.pop(context, selectedResult);
            // showResults(context);
          },
        );
      },
    );

  }

}