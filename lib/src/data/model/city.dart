class City {
  int _id;
  String _name;

  City.fromJSON(json){
    _id = json['id'];
    _name = json['name'];
  }

  int get id => _id;
  String get name => _name;

  @override
  String toString() {
    return name;
  }
}