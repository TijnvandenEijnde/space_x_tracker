import 'package:json_annotation/json_annotation.dart';

part 'mass.g.dart';

@JsonSerializable()
class Mass {
  final int? kg;

  Mass({
    required this.kg,
  });

  factory Mass.fromJson(Map<String, dynamic> json) => _$MassFromJson(json);
  Map<String, dynamic> toJson() => _$MassToJson(this);
}
