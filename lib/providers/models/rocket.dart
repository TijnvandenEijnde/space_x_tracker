import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:space_x_tracker/providers/models/length.dart';
import 'package:space_x_tracker/providers/models/mass.dart';

part 'rocket.g.dart';

@JsonSerializable()
class Rocket {
  final bool? active;
  final int? boosters;
  final String? company;
  final int? costPerLaunch;
  final String? country;
  final String? description;
  final Length? diameter;
  final List<String>? flickrImages;
  final Length? height;
  final Mass? mass;
  final String? name;
  final int? stages;
  final int? successRatePct;

  Rocket({
    required this.active,
    required this.boosters,
    required this.company,
    required this.country,
    required this.costPerLaunch,
    required this.description,
    required this.diameter,
    required this.flickrImages,
    required this.height,
    required this.mass,
    required this.name,
    required this.stages,
    required this.successRatePct,
  });

  Map<String, dynamic> get rocketMeasurements {
    return {
      "height": height?.meters == null ? 'Unknown' : '${height?.meters} m',
      "diameter": diameter?.meters == null ? 'Unkown' : '${diameter?.meters} m',
      "mass": mass?.kg == null ? 'Unknown' : '${mass?.kg} kg',
      "stages": '$stages',
      "boosters": '$boosters',
      "successRatePercentage": '$successRatePct%',
    };
 }

 String get launchPrice {
    return NumberFormat.compactCurrency(locale: 'en_US', symbol: '\$').format(costPerLaunch).toString();
 }

  factory Rocket.fromJson(Map<String, dynamic> json) => _$RocketFromJson(json);

  Map<String, dynamic> toJson() => _$RocketToJson(this);
}
