import 'package:json_annotation/json_annotation.dart';

part 'crew.g.dart';

@JsonSerializable()
class Crew {
  final String? id;
  final String? role;

  Crew({
    required this.id,
    required this.role,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);
}
