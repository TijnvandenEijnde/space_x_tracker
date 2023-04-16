import 'package:json_annotation/json_annotation.dart';

part 'rocket.g.dart';

@JsonSerializable()
class Rocket {
  final bool? active;
  final String? company;
  final String? country;
  final String? description;
  final List<String>? flickrImages;
  final String? name;
  final String? type;

  Rocket({
    required this.active,
    required this.company,
    required this.country,
    required this.description,
    required this.flickrImages,
    required this.name,
    required this.type,
  });

  factory Rocket.fromJson(Map<String, dynamic> json) => _$RocketFromJson(json);
  Map<String, dynamic> toJson() => _$RocketToJson(this);
}
