// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SolveDomain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Solve _$SolveFromJson(Map<String, dynamic> json) {
  return Solve(json['id'] as String, json['duration'] as int,
      json['dnf'] as bool, json['plusTwo'] as bool)
    ..time =
        json['time'] == null ? null : DateTime.parse(json['time'] as String);
}

Map<String, dynamic> _$SolveToJson(Solve instance) => <String, dynamic>{
      'id': instance.id,
      'duration': instance.duration,
      'dnf': instance.dnf,
      'plusTwo': instance.plusTwo,
      'time': instance.time?.toIso8601String()
    };
