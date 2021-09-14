class CountryModel {
  String id;
  String name;
  List<dynamic> cities;

  CountryModel(this.name);

  CountryModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.cities = map['cities'];
  }
}
