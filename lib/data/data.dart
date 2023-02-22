//create a empty list
//create a empty list

import '../model/person_details.dart';

List<PersonDetail> allPersons = [];

//create a function to add a Person to the list
void addToPerson(PersonDetail personObj) {
  allPersons.add(personObj);
}

//create a function to delete a Person from the list
void deleteFromPerson(PersonDetail personObj) {
  allPersons.remove(personObj);
}

//create a function to edit a Person list
void editPerson(PersonDetail oldPersonObj, PersonDetail newPersonObj) {
  deleteFromPerson(oldPersonObj);
  addToPerson(newPersonObj);
}
