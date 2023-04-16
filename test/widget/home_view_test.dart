import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_x_tracker/project_theme.dart';
import 'package:space_x_tracker/providers/launch_provider.dart';
import 'package:space_x_tracker/views/filter_view.dart';
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
        routes: {
          FilterView.routeName: (context) => const FilterView(),
        },
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
  setUp(() => SharedPreferences.setMockInitialValues({}));

  group('cards', () {
    testWidgets('it does show a list of launch cards',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester);
      await tester.pumpAndSettle();

      Finder launchCards = find.byType(LaunchCard);

      expect(launchCards, findsNWidgets(3));
    });
  });

  group('ordering', () {
    testWidgets('it can reverse the order of the list',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester);
      await tester.pumpAndSettle();

      Finder failedLaunchCard = find.byType(LaunchCard).first;
      LaunchCard failedLaunchCardWidget = tester.widget(failedLaunchCard);

      expect(failedLaunchCardWidget.launch.status, 'FAILED');

      Finder orderButton = find.byIcon(Icons.swap_vert);

      await tester.tap(orderButton);
      await tester.pump();

      Finder upcomingLaunchCard = find.byType(LaunchCard).first;
      LaunchCard upcomingLaunchCardWidget = tester.widget(upcomingLaunchCard);

      expect(upcomingLaunchCardWidget.launch.status, 'UPCOMING');
    });
  });

  group('sorting', () {
    testWidgets('it can sort the list', (WidgetTester tester) async {
      await createWidgetUnderTest(tester);
      await tester.pumpAndSettle();

      Finder failedLaunchCard = find.byType(LaunchCard).first;
      LaunchCard failedLaunchCardWidget = tester.widget(failedLaunchCard);

      expect(failedLaunchCardWidget.launch.status, 'FAILED');

      Finder sortButton = find.byIcon(Icons.sort);

      await tester.tap(sortButton);
      await tester.pumpAndSettle();

      Finder sortByName = find.text('Name');

      await tester.tap(sortByName);
      await tester.tapAt(const Offset(20.0, 20.0));
      await tester.pumpAndSettle();

      Finder upcomingLaunchCard = find.byType(LaunchCard).first;
      LaunchCard upcomingLaunchCardWidget = tester.widget(upcomingLaunchCard);

      expect(upcomingLaunchCardWidget.launch.status, 'UPCOMING');
    });
  });

  group('filtering', () {
    testWidgets('it can filter the list', (WidgetTester tester) async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      await createWidgetUnderTest(tester);
      await tester.pumpAndSettle();

      Finder filterButton = find.byIcon(Icons.filter_alt);

      await tester.tap(filterButton);
      await tester.pumpAndSettle();

      Finder upcoming = find.text('Upcoming');
      await tester.tap(upcoming);
      await tester.pumpAndSettle();

      Finder apply = find.text('Apply');
      await tester.tap(apply);
      await tester.pump();

      Finder launchCard = find.byType(LaunchCard);
      LaunchCard launchCardWidget = tester.widget(launchCard);

      expect(launchCard, findsNWidgets(1));
      expect(launchCardWidget.launch.status, 'UPCOMING');
      expect(
          preferences.getString('filters'),
          jsonEncode({
            'statuses': ['upcoming'],
          }));
    });
  });

  group('searching', () {
    testWidgets('it can search the list', (WidgetTester tester) async {
      await createWidgetUnderTest(tester);
      await tester.pumpAndSettle();

      Finder searchButton = find.byIcon(Icons.search);

      await tester.tap(searchButton);
      await tester.pumpAndSettle();

      Finder query = find.byType(TextField);
      await tester.enterText(query, 'falconY');
      await tester.pumpAndSettle();

      Finder launchCard = find.byType(LaunchCard);
      LaunchCard launchCardWidget = tester.widget(launchCard);

      expect(launchCard, findsNWidgets(1));
      expect(launchCardWidget.launch.status, 'SUCCESS');
    });
  });
}
