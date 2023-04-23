import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:space_x_tracker/project_theme.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/providers/models/rocket.dart';
import 'package:space_x_tracker/providers/rocket_provider.dart';
import 'package:space_x_tracker/screens/rocket_screen.dart';
import 'package:space_x_tracker/widgets/home/launch_card.dart';
import 'package:space_x_tracker/widgets/rocket/rocket_cover_image.dart';

import '../data/launch_data.dart';
import '../data/rocket_data.dart';
import 'rocket_view_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final isWidgetTest = Platform.environment.containsKey('FLUTTER_TEST');
  final http.Client client = MockClient();
  final theme = ProjectTheme.lightTheme;
  final Launch launch = LaunchData.launchWithoutPatch;
  final Rocket rocket =
      isWidgetTest == false ? RocketData.rocket : RocketData.rocketWithoutImage;

  if (isWidgetTest == false) {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  }

  Future<void> createWidgetUnderTest(WidgetTester tester) async {
    Widget widgetUnderTest = ChangeNotifierProvider(
      create: (context) => RocketProvider(),
      child: MaterialApp(
        home: Material(child: LaunchCard(launch: launch)),
        theme: theme,
        routes: {
          RocketView.routeName: (context) => RocketView(client: client),
        },
      ),
    );

    await tester.pumpWidget(widgetUnderTest);
  }

  when(client.get(
    Uri.parse('https://api.spacexdata.com/v4/rockets/${launch.rocket}'),
  )).thenAnswer(
    (_) async => http.Response(jsonEncode(rocket.toJson()), 200),
  );

  // Prevents NetworkImage failures the solution with network_image_mock is not working in this case.
  setUpAll(() => HttpOverrides.global = null);

  testWidgets('it displays the correct data on the rocket page',
      (WidgetTester tester) async {
    await createWidgetUnderTest(tester);

    Finder launchCard = find.byType(LaunchCard);
    expect(launchCard, findsOneWidget);

    await tester.tap(launchCard);
    await tester.pumpAndSettle();

    Finder rocketCoverImage = find.byType(RocketCoverImage);
    Finder statusText = find.text(rocket.statusText);
    Finder launchPrice = find.text(rocket.launchPrice);
    Finder successRate = find.text('${rocket.successRatePct}%');

    Finder name = find.text(rocket.name!);
    Finder height = find.text(rocket.rocketDetails['height']);
    Finder diameter = find.text((rocket.rocketDetails['diameter']));
    Finder mass = find.text((rocket.rocketDetails['mass']));
    Finder stages = find.text((rocket.rocketDetails['stages']));
    Finder boosters = find.text((rocket.rocketDetails['boosters']));
    Finder payloads = find.text((rocket.rocketDetails['payloads']));

    expect(rocketCoverImage, findsOneWidget);
    expect(rocket.status, Icons.check_circle);
    expect(statusText, findsOneWidget);
    expect(successRate, findsOneWidget);
    expect(launchPrice, findsOneWidget);

    expect(name, findsOneWidget);
    expect(height, findsOneWidget);
    expect(diameter, findsOneWidget);
    expect(mass, findsOneWidget);
    expect(stages, findsOneWidget);
    expect(boosters, findsOneWidget);
    expect(payloads, findsOneWidget);
  });
}
