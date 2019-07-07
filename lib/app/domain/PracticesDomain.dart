import 'package:json_annotation/json_annotation.dart';

import 'package:cube_timer/app/cube/type/CubeType.dart';
import 'package:cube_timer/app/practice/domain/PracticeDomain.dart';

part 'PracticesDomain.g.dart';

@JsonSerializable()
class Practices {
  var cubeTypes = Map<CubeType, List<Practice>>();

  Practices(this.cubeTypes);

  factory Practices.fromJson(Map<String, dynamic> json) => _$PracticesFromJson(json);

  Map<String, dynamic> toJson() => _$PracticesToJson(this);
}
