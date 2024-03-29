// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PracticesDomain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Practices _$PracticesFromJson(Map<String, dynamic> json) {
  return Practices((json['cubeTypes'] as Map<String, dynamic>)?.map(
    (k, e) => MapEntry(
        _$enumDecodeNullable(_$CubeTypeEnumMap, k),
        (e as List)
            ?.map((e) =>
                e == null ? null : Practice.fromJson(e as Map<String, dynamic>))
            ?.toList()),
  ));
}

Map<String, dynamic> _$PracticesToJson(Practices instance) => <String, dynamic>{
      'cubeTypes':
          instance.cubeTypes?.map((k, e) => MapEntry(_$CubeTypeEnumMap[k], e))
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$CubeTypeEnumMap = <CubeType, dynamic>{
  CubeType.CUBE_2x2x2: 'CUBE_2x2x2',
  CubeType.CUBE_3x3x3: 'CUBE_3x3x3',
  CubeType.CUBE_4x4x4: 'CUBE_4x4x4',
  CubeType.CUBE_5x5x5: 'CUBE_5x5x5',
  CubeType.CUBE_6x6x6: 'CUBE_6x6x6',
  CubeType.CUBE_7x7x7: 'CUBE_7x7x7'
};
