import 'package:crud_operation_in_list/view/person_widget.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import '../data/data.dart';

import '../model/person_details.dart';
import 'add_edit_person.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<PersonDetail?> addEditPerson(PersonDetail? person) async {
    return await showDialog<PersonDetail?>(
        context: context,
        builder: (context) {
          return Dialog(
            child: AddEditPerson(
              person: person,
            ),
          );
        });
  }

  Future<bool?> showConfirmation(PersonDetail? item) async {
    return await showDialog<bool?>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Confirm'),
            content: const Text('Are You Sure Wants to Delete'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Ok')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancel')),
            ],
          );
        });
  }

  List<PersonDetail> filteredList = <PersonDetail>[];

  var searchPerson = '';

  @override
  void initState() {
    filteredList.clear();
    filteredList.addAll(allPersons);
    super.initState();
  }

  List<String> getSuggestion() {
    var suggestion = <String>[];
    for (var person in allPersons) {
      if (suggestion.contains(person.name) == false) {
        suggestion.add(person.name!);
      }
    }
    return suggestion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('Crud Search'),
        suggestionTextStyle:
            const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
        suggestions: getSuggestion(),
        onSearch: (value) async {
          searchPerson = value;

          applyFilter();
          setState(() {});
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newPerson = await addEditPerson(null);
          if (newPerson != null) {
            addToPerson(newPerson);
            applyFilter();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return ListView(children: getPersonWidgets(filteredList));
  }

  List<Widget> getPersonWidgets(List<PersonDetail> persons) {
    return persons
        .map((e) => GestureDetector(
              onLongPress: () async {
                var canDelete = await showConfirmation(e);
                if (canDelete!) {
                  setState(() {
                    deleteFromPerson(e);
                    applyFilter();
                  });
                }
              },
              onTap: () async {
                var newPerson = await addEditPerson(e);
                if (newPerson != null) {
                  setState(() {
                    editPerson(e, newPerson);
                    applyFilter();
                  });
                }
              },
              child: PersonWidget(person: e),
            ))
        .toList();
  }

  Widget searchBar() {
    return TextField(
      onChanged: (value) {
        searchPerson = value;
        applyFilter();
      },
    );
  }

  void applyFilter() {
    setState(() {
      filteredList = allPersons
          .where((element) =>
              element.age!.toString().contains(searchPerson) &&
              element.name!.contains(searchPerson))
          .toList();
    });
  }
}
