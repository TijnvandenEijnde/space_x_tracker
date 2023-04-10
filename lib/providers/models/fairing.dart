import 'package:json_annotation/json_annotation.dart';

part 'fairing.g.dart';

@JsonSerializable()
class Fairing {
  final bool? reused;
  final bool? recoveryAttempt;
  final bool? recovered;
  final List<String>? ships;

  Fairing({
    required this.reused,
    required this.recoveryAttempt,
    required this.recovered,
    required this.ships,
  });

  factory Fairing.fromJson(Map<String, dynamic> json) =>
      _$FairingFromJson(json);
}
