import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:space_x_tracker/project_theme.dart';
import 'package:space_x_tracker/providers/launch_provider.dart';
import 'package:space_x_tracker/views/home_view.dart';
import 'package:space_x_tracker/widgets/launch_card.dart';

import 'home_view_test.mocks.dart';
import 'launch_data.dart';

@GenerateMocks([http.Client])
void main() {
  final http.Client client = MockClient();
  final theme = ProjectTheme.lightTheme;
  final List<Map<String, dynamic>> launches = LaunchData.encodedLaunches;

  Future<void> createWidgetUnderTest(WidgetTester tester) async {
    Widget widgetUnderTest = ChangeNotifierProvider(
      create: (context) => LaunchProvider(),
      child: MaterialApp(
        home: HomeView(client: client),
        theme: theme,
      ),
    );

    await tester.pumpWidget(widgetUnderTest);
  }

  when(client.get(Uri.parse('https://api.spacexdata.com/v5/launches')))
      .thenAnswer(
        (_) async => http.Response(jsonEncode(launches), 200),
  );

  // Prevents NetworkImage failures the solution with network_image_mock is not working in this case.
  setUpAll(() => HttpOverrides.global = null);

  group('filtering', () {
    testWidgets('it will toggle active filters', (WidgetTester tester) async {
      await createWidgetUnderTest(tester);
      await tester.pumpAndSettle();

      Finder launchCards = find.byType(LaunchCard);

      expect(launchCards, findsNWidgets(3));
    });
  });
}
