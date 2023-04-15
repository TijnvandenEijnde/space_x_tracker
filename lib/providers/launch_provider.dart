import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_x_tracker/providers/models/launch.dart';

class LaunchProvider extends ChangeNotifier {
  List<Launch> _launches = [];
  List<Launch> _filteredLaunches = [];
  bool filtered = false;

  List<Launch> get allLaunches {
    if (filtered == true) {
      return _filteredLaunches;
    }

    return _launches;
  }

  void sortLaunches(String attribute) {
    final List<Launch> launches = filtered == true ? _filteredLaunches : _launches;

    launches.sort((a, b) {
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

        case 'status':
          {
            return a.status.toLowerCase().compareTo(b.status.toLowerCase());
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
    if (filtered == true) {
      _filteredLaunches = _filteredLaunches.reversed.toList();
    } else {
      _launches = _launches.reversed.toList();
    }

    notifyListeners();
  }

  Future<void> filterLaunches(Map<String, List<String>> filters) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    if (filters.isEmpty == true) {
      filtered = false;
      preferences.remove('filters');
      notifyListeners();
    } else {
      filtered = true;
      _filteredLaunches = _launches.where((element) {
        if ((filters.containsKey('years') && filters['years'] != []) && (filters.containsKey('statuses') && filters['statuses'] != [])) {
          return filters['years']!.contains(element.dateLocal!.year.toString())
              && filters['statuses']!.contains(element.status.toLowerCase());
        }

        if (filters.containsKey('years') && filters['years'] != []) {
          return filters['years']!.contains(element.dateLocal!.year.toString());
        }

        return filters['statuses']!.contains(element.status.toLowerCase());
      }).toList();

      String filterList = jsonEncode((filters));
      preferences.setString('filters', filterList);
      notifyListeners();
    }
  }

  Future<void> fetchLaunches(http.Client client) async {
    final url = Uri.parse('https://api.spacexdata.com/v5/launches');

    try {
      final response = await client.get(url);
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      _launches = parsed.map<Launch>((json) => Launch.fromJson(json)).toList();

      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }
}
