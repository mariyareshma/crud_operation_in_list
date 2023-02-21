import 'package:crud_operation_in_list/view/person_widget.dart';
import 'package:flutter/material.dart';
import '../data/data.dart';
import '../model/model.dart';
import 'add_edit_Person.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newPerson = await addEditPerson(null);
          if (newPerson != null) {
            setState(() {
              addToPerson(newPerson);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: getPersonWidgets(allPersons),
      ),
    );
  }

  List<Widget> getPersonWidgets(List<PersonDetail> persons) {
    return persons
        .map((e) => GestureDetector(
              onLongPress: () async {
                var canDelete = await showConfirmation(e);
                if (canDelete!) {
                  setState(() {
                    deleteFromPerson(e);
                  });
                }
              },
              onTap: () async {
                var newPerson = await addEditPerson(e);
                if (newPerson != null) {
                  setState(() {
                    editPerson(e, newPerson);
                  });
                }
              },
              child: PersonWidget(person: e),
            ))
        .toList();
  }
}
