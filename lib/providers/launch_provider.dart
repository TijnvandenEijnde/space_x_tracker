import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:space_x_tracker/providers/models/launch.dart';

class LaunchProvider extends ChangeNotifier {
  List<Launch> _launches = [];

  List<Launch> get allLaunches {
    return _launches;
  }

  void sortLaunches() {
    _launches.sort((a, b) => a.name!.compareTo(b.name!));
    notifyListeners();
  }

  Future<void> fetchLaunches() async {
    final url = Uri.parse('https://api.spacexdata.com/v5/launches');

    try {
      final response = await http.get(url);
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      _launches = parsed.map<Launch>((json) => Launch.fromJson(json)).toList();

      notifyListeners();

    } catch (_) {
      rethrow;
    }
  }
}
