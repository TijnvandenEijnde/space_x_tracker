import 'package:space_x_tracker/providers/models/core.dart';
import 'package:space_x_tracker/providers/models/crew.dart';
import 'package:space_x_tracker/providers/models/failure.dart';
import 'package:space_x_tracker/providers/models/fairing.dart';

class Launch {
  final bool autoUpdate;
  final String? article;
  final List<String>? capsules;
  final List<Core> cores;
  final List<Crew>? crew;
  final DateTime dateLocal;
  final String datePrecision;
  final DateTime dateUnix;
  final DateTime dateUtc;
  final String? details;
  final List<Failure>? failures;
  final List<Fairing>? fairings;
  final String flightNumber;
  final String id;
  final String launchLibraryId;
  final String launchpad;
  final String name;
  final bool net;
  final String patch;
  final List<String>? payloads;
  final String rocket;
  final List<String>? ships;
  final DateTime? staticFireDateUnix;
  final DateTime? staticFireDateUtc;
  final bool success;
  final bool tbd;
  final bool upcoming;
  final String webcast;
  final String? window;

  Launch({
    required this.autoUpdate,
    required this.article,
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
    required this.name,
    required this.net,
    required this.patch,
    required this.payloads,
    required this.rocket,
    required this.ships,
    required this.staticFireDateUnix,
    required this.staticFireDateUtc,
    required this.success,
    required this.tbd,
    required this.upcoming,
    required this.webcast,
    required this.window,
  });
}
