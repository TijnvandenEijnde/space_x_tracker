import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:space_x_tracker/providers/models/rocket.dart';

class RocketProvider extends ChangeNotifier {
  Rocket _rocket = Rocket(
    active: null,
    company: '',
    country: '',
    description: '',
    flickrImages: [],
    name: null,
    type: '',
  );

  Future<Rocket> fetchRocket(http.Client client, String rocketId) async {
    final url = Uri.parse('https://api.spacexdata.com/v4/rockets/$rocketId');

    try {
      final response = await client.get(url);
      final parsed = jsonDecode(response.body);
      _rocket = Rocket.fromJson(parsed);

      return Future.value(_rocket);
    } catch (_) {
      rethrow;
    }
  }
}
