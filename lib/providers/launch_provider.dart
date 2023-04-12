import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:space_x_tracker/providers/models/launch.dart';

class LaunchProvider extends ChangeNotifier {
  List<Launch> _launches = [];

  List<Launch> get allLaunches {
    return _launches;
  }

  void sortLaunches(String attribute) {
    _launches.sort((a, b) {
      switch (attribute) {
        case 'name':
          {
            // Make sure that null values are checked and places them at the end of the list
            return a.name == null
                ? 1
                : b.name == null
                    ? -1
                    : a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
          }

        case 'dateLocal':
          {
            {
              return a.dateLocal == null
                  ? 1
                  : b.dateLocal == null
                      ? -1
                      : a.dateLocal!.compareTo(b.dateLocal!);
            }
          }

        case 'status': {
          return a.determineStatus.toLowerCase().compareTo(b.determineStatus.toLowerCase());
        }

        default:
          {
            return a.flightNumber == null
                ? 1
                : b.flightNumber == null
                    ? -1
                    : a.flightNumber!.compareTo(b.flightNumber!);
          }
      }
    });
    notifyListeners();
  }

  void reverseLaunches() {
    _launches = _launches.reversed.toList();
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
