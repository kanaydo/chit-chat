class Transaction {
  int _id;
  String _date;
  int _points;
  String _price;
  String _reward;
  String _type;
  int _status;
  String _weight;

  Transaction.fromJSON(json) {
    _id = json['id'];
    _date = json['date'];
    _points = json['points'];
    _price = json['price'];
    _reward = json['reward'];
    _type = json['type'];
    _status = json['status'];
    _weight = json['weight'];
  }

  int get id => _id;
  String get date => _date;
  int get points => _points;
  String get price => _price;
  String get reward => _reward;
  String get type => _type;
  int get status => _status;
  String get weight => '$_weight gr';
}