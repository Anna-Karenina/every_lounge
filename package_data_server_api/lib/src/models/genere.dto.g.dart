// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genere.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenereDTO _$GenereDTOFromJson(Map<String, dynamic> json) => GenereDTO(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GenereDTOToJson(GenereDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
