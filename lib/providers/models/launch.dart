import 'package:json_annotation/json_annotation.dart';
import 'package:space_x_tracker/providers/models/core.dart';
import 'package:space_x_tracker/providers/models/crew.dart';
import 'package:space_x_tracker/providers/models/failure.dart';
import 'package:space_x_tracker/providers/models/fairing.dart';
import 'package:space_x_tracker/providers/models/link.dart';

part 'launch.g.dart';

@JsonSerializable()
class Launch {
  final bool? autoUpdate;
  final List<String>? capsules;
  final List<Core>? cores;
  final List<Crew>? crew;
  final DateTime? dateLocal;
  final String? datePrecision;
  final int? dateUnix;
  final DateTime? dateUtc;
  final String? details;
  final List<Failure>? failures;
  final Fairing? fairings;
  final int? flightNumber;
  final String? id;
  final String? launchLibraryId;
  final String? launchpad;
  final Link? links;
  final String? name;
  final bool? net;
  final List<String>? payloads;
  final String? rocket;
  final List<String>? ships;
  final int? staticFireDateUnix;
  final DateTime? staticFireDateUtc;
  final bool? success;
  final bool? tbd;
  final bool? upcoming;
  final int? window;

  Launch({
    required this.autoUpdate,
    required this.capsules,
    required this.cores,
    required this.crew,
    required this.dateLocal,
    required this.datePrecision,
    required this.dateUnix,
    required this.dateUtc,
    required this.details,
    required this.failures,
    required this.fairings,
    required this.flightNumber,
    required this.id,
    required this.launchLibraryId,
    required this.launchpad,
    required this.links,
    required this.name,
    required this.net,
    required this.payloads,
    required this.rocket,
    required this.ships,
    required this.staticFireDateUnix,
    required this.staticFireDateUtc,
    required this.success,
    required this.tbd,
    required this.upcoming,
    required this.window,
  });

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);

  String get status {
    return success == null || success == false
        ? upcoming == true
            ? 'UPCOMING'
            : 'FAILED'
        : 'SUCCESS';
  }
}
