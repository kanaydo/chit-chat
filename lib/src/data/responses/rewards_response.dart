import 'package:flutter_base_app/src/data/model/reward.dart';

class RewardsResponse {
  List<Reward> _rewards;

  RewardsResponse.fromJson(json) {
    _rewards = List<Reward>.of(
        json.map<Reward>((reward) => new Reward.fromJSON(reward))
    );
  }

  List<Reward> get rewards => _rewards;
}