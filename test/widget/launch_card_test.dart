import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/intl.dart';
import 'package:space_x_tracker/project_theme.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/widgets/home/card/icon_row_item.dart';
import 'package:space_x_tracker/widgets/home/card/patch.dart';
import 'package:space_x_tracker/widgets/home/card/launch_card.dart';

import 'data/launch_data.dart';

void main() {
  if (Platform.environment.containsKey('FLUTTER_TEST') == false) {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  }

  final Launch launch = LaunchData.failedLaunch;
  const Color errorColor = Color(0xffb00020);
  const Color successColor = Color(0xFF39DC03);
  const Color tertiaryColor = Color(0xfffb8122);

  Future<void> createWidgetUnderTest(WidgetTester tester, Launch launch) async {
    Widget widgetUnderTest = MaterialApp(
      home: Material(child: LaunchCard(launch: launch)),
      theme: ProjectTheme.lightTheme,
    );
    await tester.pumpWidget(widgetUnderTest);
  }

  setUpAll(() => HttpOverrides.global = null);

  group('display', () {
    testWidgets('it displays the correct data on the card',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester, launch);

      Finder patch = find.byType(Patch);
      Patch patchWidget = tester.widget(patch);

      Finder flightNumber = find.text('#${launch.flightNumber.toString()}');
      Finder name = find.text(launch.name!);
      Finder failed = find.text('FAILED');
      Finder date = find.text(
        DateFormat('MMM d y, h:mm:ss a').format(launch.dateLocal!),
      );
      Finder icons = find.byType(IconRowItem);
      IconRowItem crew = tester.widget(icons.first);

      expect(patch, findsOneWidget);
      expect(patchWidget.networkSource, launch.links!.patch!.small!);

      expect(flightNumber, findsOneWidget);
      expect(name, findsOneWidget);
      expect(failed, findsOneWidget);
      expect(date, findsOneWidget);

      expect(icons, findsNWidgets(4));
      expect(crew.count, launch.crew!.length.toString());
      expect(crew.icon, Icons.person);
    });

    testWidgets('it displays the default placeholder when patch data is null',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester, LaunchData.upcomingLaunch);

      Finder patch = find.byType(Patch);
      expect(patch, findsOneWidget);

      Finder placeHolder = find.byType(Image);
      expect(placeHolder, findsOneWidget);

      Image placeHolderImage = tester.widget(placeHolder);
      AssetImage placeHolderAssetImage = placeHolderImage.image as AssetImage;

      expect(placeHolderAssetImage.assetName,
          'assets/placeholders/rocket-placeholder-small.png');
    });
  });

  group('status', () {
    testWidgets(
        'it should change the status to failed and the color to the error color when success data is false',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester, launch);

      Finder status = find.text('FAILED');
      Text statusTextWidget = tester.widget(status);

      Finder card = find.byType(Card);
      Card cardWidget = tester.widget<Card>(card);

      final shape = cardWidget.shape as RoundedRectangleBorder;
      final side = shape.side;
      final borderColor = side.color;

      expect(status, findsOneWidget);
      expect(statusTextWidget.style?.color, errorColor);
      expect(card, findsOneWidget);
      expect(borderColor, errorColor);
    });

    testWidgets(
        'it should change the status to success and the color to the success color when success data is true',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester, LaunchData.successLaunch);

      Finder status = find.text('SUCCESS');
      Text statusTextWidget = tester.widget(status);

      Finder card = find.byType(Card);
      Card cardWidget = tester.widget<Card>(card);

      final shape = cardWidget.shape as RoundedRectangleBorder;
      final side = shape.side;
      final borderColor = side.color;

      expect(status, findsOneWidget);
      expect(statusTextWidget.style?.color, successColor);
      expect(card, findsOneWidget);
      expect(borderColor, successColor);
    });

    testWidgets(
        'it should change the status to upcoming and the color to the tertiary color when upcoming data is true',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester, LaunchData.upcomingLaunch);

      Finder status = find.text('UPCOMING');
      Text statusTextWidget = tester.widget(status);

      Finder card = find.byType(Card);
      Card cardWidget = tester.widget<Card>(card);

      final shape = cardWidget.shape as RoundedRectangleBorder;
      final side = shape.side;
      final borderColor = side.color;

      expect(status, findsOneWidget);
      expect(statusTextWidget.style?.color, tertiaryColor);
      expect(card, findsOneWidget);
      expect(borderColor, tertiaryColor);
    });
  });
}
