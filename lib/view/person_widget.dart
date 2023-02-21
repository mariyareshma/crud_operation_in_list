import 'package:flutter/material.dart';

import '../model/model.dart';

class PersonWidget extends StatelessWidget {
  const PersonWidget({Key? key, this.person}) : super(key: key);
  final PersonDetail? person;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('Name:${person!.name!}'),
        subtitle: Text('Age:${person!.age!.toString()}'));
  }
}
