class Village {
  int _id;
  String _name;

  Village.fromJSON(json) {
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