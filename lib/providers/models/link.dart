import 'package:json_annotation/json_annotation.dart';
import 'package:space_x_tracker/providers/models/patch.dart';

part 'link.g.dart';

@JsonSerializable()
class Link {
  final Patch? patch;
  final String? webcast;
  final String? article;

  Link({
    required this.patch,
    required this.webcast,
    required this.article,
  });

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
