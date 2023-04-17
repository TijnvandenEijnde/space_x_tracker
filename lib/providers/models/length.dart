import 'package:json_annotation/json_annotation.dart';

part 'length.g.dart';

@JsonSerializable()
class Length {
  final double? meters;

  Length({
    required this.meters,
  });

  factory Length.fromJson(Map<String, dynamic> json) => _$LengthFromJson(json);
  Map<String, dynamic> toJson() => _$LengthToJson(this);
}
