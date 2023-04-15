import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/widgets/card_list_view.dart';
import 'package:space_x_tracker/widgets/launch_card.dart';

import 'launch_data.dart';

void main() {
  final List<Launch> launches = LaunchData.launches;

  Future<void> createWidgetUnderTest(WidgetTester tester) async {
    Widget widgetUnderTest = MaterialApp(
      home: CardViewList(launches: launches),
    );

    await tester.pumpWidget(widgetUnderTest);
  }

  setUpAll(() => HttpOverrides.global = null);

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
