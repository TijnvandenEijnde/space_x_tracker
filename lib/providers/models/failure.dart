import 'package:json_annotation/json_annotation.dart';

part 'failure.g.dart';

@JsonSerializable()
class Failure {
  final int? timeInSeconds;
  final int? altitude;
  final String? reason;

  Failure({
    required this.timeInSeconds,
    required this.altitude,
    required this.reason,
  });

  factory Failure.fromJson(Map<String, dynamic> json) =>
      _$FailureFromJson(json);
  Map<String, dynamic> toJson() => _$FailureToJson(this);
}
