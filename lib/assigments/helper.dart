import 'package:chat_app/assigments/model.dart';
import 'package:chat_app/auth/helpers/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CountryHelper {
  CountryHelper._();

 static CountryHelper countryHelper = CountryHelper._();

  Future<List<CountryModel>> getAllCountiesFromFireStore() async {
    QuerySnapshot querySnapshot = await FireStoreHelper
        .fireStoreHelper.firestore
        .collection('countries')
        .get();
    return querySnapshot.docs
        .map((element) => CountryModel.fromMap(element.data()))
        .toList();
  }
}
