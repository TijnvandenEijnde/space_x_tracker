import 'package:json_annotation/json_annotation.dart';
import 'package:space_x_tracker/providers/models/core.dart';
import 'package:space_x_tracker/providers/models/crew.dart';
import 'package:space_x_tracker/providers/models/link.dart';

part 'launch.g.dart';

@JsonSerializable()
class Launch {
  // @todo add getters for all the values that are used, in the future the data that is not needed can be removed.
  final List<Core>? cores;
  final List<Crew>? crew;
  final DateTime? dateLocal;
  final int? flightNumber;
  final Link? links;
  final String? name;
  final List<String>? payloads;
  final String? rocket;
  final List<String>? ships;
  final bool? success;
  final bool? upcoming;

  Launch({
    required this.cores,
    required this.crew,
    required this.dateLocal,
    required this.flightNumber,
    required this.links,
    required this.name,
    required this.payloads,
    required this.rocket,
    required this.ships,
    required this.success,
    required this.upcoming,
  });

  String get status {
    return success == null || success == false
        ? upcoming == true
            ? 'UPCOMING'
            : 'FAILED'
        : 'SUCCESS';
  }

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);
  Map<String, dynamic> toJson() => _$LaunchToJson(this);
}
