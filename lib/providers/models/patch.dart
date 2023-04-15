import 'package:json_annotation/json_annotation.dart';

part 'patch.g.dart';

@JsonSerializable()
class Patch {
  final String? small;
  final String? large;

  Patch({
    required this.small,
    required this.large,
  });

  factory Patch.fromJson(Map<String, dynamic> json) => _$PatchFromJson(json);
  Map<String, dynamic> toJson() => _$PatchToJson(this);
}
