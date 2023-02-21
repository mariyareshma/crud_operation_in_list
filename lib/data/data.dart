//create a empty list
//create a empty list

import '../model/model.dart';

List<PersonDetail?> listofPersons = [];

//create a function to add a Person to the list
void addToPerson(PersonDetail personObj) {
  listofPersons.add(personObj);
}

//create a function to delete a Person from the list
void deleteFromPerson(PersonDetail personObj) {
  listofPersons.remove(personObj);
}

//create a function to edit a Person list
void editPerson(PersonDetail oldPersonObj, PersonDetail newPersonObj) {
  deleteFromPerson(oldPersonObj);
  addToPerson(newPersonObj);
}
