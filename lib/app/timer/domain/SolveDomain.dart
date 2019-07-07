import 'package:json_annotation/json_annotation.dart';

part 'SolveDomain.g.dart';

@JsonSerializable()
class Solve {
  String id;
  int duration;
  bool dnf;
  bool plusTwo;
  DateTime time;

  Solve(this.id, this.duration, this.dnf, this.plusTwo);

  factory Solve.fromJson(Map<String, dynamic> json) => _$SolveFromJson(json);

  Map<String, dynamic> toJson() => _$SolveToJson(this);
}
