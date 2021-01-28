import '../BaseEntity.dart';
import '../StateEntity.dart';

class NotifyProjectModel extends BaseEntity {
  StateEntity states;
  String name;

  NotifyProjectModel({this.states = StateEntity.None, this.name});

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  fromJson(Map<String, dynamic> json) => {
        this.name: json["name"],
      };
}
