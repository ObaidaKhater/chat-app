import 'package:chat_app/assigments/helper.dart';
import 'package:chat_app/assigments/model.dart';
import 'package:flutter/cupertino.dart';

class CountryProvider extends ChangeNotifier {
  List<CountryModel> countries;
  List<dynamic> cities;
  CountryModel selectCount;
  String selectCit;

  CountryProvider(){
    getCountries();
  }

  getCountries() async {
    List<CountryModel> co = await CountryHelper.countryHelper
        .getAllCountiesFromFireStore();
    this.countries = co;
    selectCountry(co.first);
  }

  selectCountry(CountryModel countryModel) {
    this.selectCount = countryModel;
    this.cities = countryModel.cities;
    selectCity(cities.first.toString());
    notifyListeners();
  }

  selectCity(dynamic city) {
    this.selectCit = city;
    notifyListeners();
  }

}
