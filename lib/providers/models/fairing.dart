class Fairing {
  final bool? reused;
  final bool? recoveryAttempt;
  final bool? recovered;
  final List<String> ships;

  Fairing({
    required this.reused,
    required this.recoveryAttempt,
    required this.recovered,
    required this.ships,
  });
}
