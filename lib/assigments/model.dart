class CountryModel {
  String id;
  String name;
  List<dynamic> cities;

  CountryModel.fromMap(Map map) {
    this.id = map['id'];
    this.name = map['name'];
    this.cities = map['cities'];
  }
}
