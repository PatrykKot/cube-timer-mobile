// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PracticeDomain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Practice _$PracticeFromJson(Map<String, dynamic> json) {
  return Practice(
      json['id'] as String,
      (json['solves'] as List)
          ?.map((e) =>
              e == null ? null : Solve.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['started'] == null
          ? null
          : DateTime.parse(json['started'] as String));
}

Map<String, dynamic> _$PracticeToJson(Practice instance) => <String, dynamic>{
      'id': instance.id,
      'solves': instance.solves,
      'started': instance.started?.toIso8601String()
    };
