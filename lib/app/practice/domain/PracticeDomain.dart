import 'package:cube_timer/app/timer/domain/SolveDomain.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'PracticeDomain.g.dart';

@JsonSerializable()
class Practice {
  String id;
  List<Solve> solves;
  DateTime started;

  Practice(this.id, this.solves, this.started);

  int get avg {
    var solveDurations = solves.where((solve) => !solve.dnf).map((solve) {
      var duration = solve.duration;
      if (solve.plusTwo) {
        duration += 2000;
      }
      return duration;
    });

    if(solveDurations.isEmpty) {
      return 0;
    }

    var sum = 0;
    solveDurations.forEach((duration) => sum += duration);
    return (sum / solveDurations.length).ceil();
  }

  factory Practice.createNew() {
    return Practice(Uuid().v1(), List<Solve>(), DateTime.now());
  }

  factory Practice.fromJson(Map<String, dynamic> json) =>
      _$PracticeFromJson(json);

  Map<String, dynamic> toJson() => _$PracticeToJson(this);
}
