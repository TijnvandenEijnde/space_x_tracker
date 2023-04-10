import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/widgets/card_list_view.dart';
import 'package:space_x_tracker/widgets/launch_card.dart';

import 'card_list_view_test.mocks.dart';
import 'launch_data.dart';

@GenerateMocks([http.Client])
void main() {
  final http.Client client = MockClient();
  final List<Launch> launches = [
    LaunchData.failedLaunch,
    LaunchData.successLaunch,
    LaunchData.upcomingLaunch,
  ];

  when(client.get(Uri.parse('https://api.spacexdata.com/v5/launches')))
      .thenAnswer(
    (_) async => http.Response(jsonEncode(LaunchData.launchData), 200),
  );

  Future<void> createWidgetUnderTest(WidgetTester tester) async {
    Widget widgetUnderTest = MaterialApp(
      home: CardViewList(client: client, launches: launches),
    );

    await mockNetworkImagesFor(() => tester.pumpWidget(widgetUnderTest));
  }

  testWidgets('it should display a list of launch cards',
      (WidgetTester tester) async {
    await createWidgetUnderTest(tester);

    Finder failedLaunchCard = find.ancestor(
      of: find.text('FAILED'),
      matching: find.byType(LaunchCard),
    );
    Finder successLaunchCard = find.ancestor(
      of: find.text('SUCCESS'),
      matching: find.byType(LaunchCard),
    );
    Finder upcomingLaunchCard = find.ancestor(
      of: find.text('UPCOMING'),
      matching: find.byType(LaunchCard),
    );
    Finder launchCards = find.byType(LaunchCard);

    expect(failedLaunchCard, findsOneWidget);
    expect(successLaunchCard, findsOneWidget);
    expect(upcomingLaunchCard, findsOneWidget);
    expect(launchCards, findsNWidgets(3));
  });
}
