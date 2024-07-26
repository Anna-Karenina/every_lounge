import 'package:json_annotation/json_annotation.dart';

part 'genere.dto.g.dart';

@JsonSerializable()
class GenereDTO {
  final int? id;
  final String? name;

  GenereDTO({this.id, this.name});

  factory GenereDTO.fromJson(Map<String, dynamic> json) =>
      _$GenereDTOFromJson(json);
}
