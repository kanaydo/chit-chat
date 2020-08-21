class Redeem {
  int _id;
  int _memberId;
  int _points;
  String _redeemedAt;
  int _rewardId;

  Redeem.fromJSON(json) {
    _id = json['id'];
    _memberId = json['member_id'];
    _points = json['points'];
    _redeemedAt = json['redeemed_at'];
    _rewardId = json['reward_id'];

  }

  int get id => _id;
  int get memberId => _memberId;
  int get points => _points;
  String get redeemedAt => _redeemedAt;
  int get rewardId => _rewardId;
}