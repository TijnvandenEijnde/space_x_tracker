import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_x_tracker/project_theme.dart';
import 'package:space_x_tracker/providers/launch_provider.dart';
import 'package:space_x_tracker/screens/filter_screen.dart';

void main() {
  if (Platform.environment.containsKey('FLUTTER_TEST') == false) {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  }

  final theme = ProjectTheme.lightTheme;
  final Color onPrimaryColor = theme!.colorScheme.onPrimary;
  final Color onPrimaryContainerColor = theme.colorScheme.onPrimaryContainer;
  final Color tertiaryColor = theme.colorScheme.tertiary;

  Future<void> createWidgetUnderTest(WidgetTester tester) async {
    Widget widgetUnderTest = ChangeNotifierProvider(
      create: (context) => LaunchProvider(),
      child: MaterialApp(
        home: const FilterView(),
        theme: theme,
      ),
    );

    await tester.pumpWidget(widgetUnderTest);
  }

  group('toggling', () {
    testWidgets(
        'it changes the color of a nonactive filter item box to tertiary and the text color to on primary when tapped',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester);

      Finder failed = find.text('Failed');
      Text failedText = tester.widget<Text>(failed);
      Finder failedContainer =
          find.ancestor(of: failed, matching: find.byType(Container)).first;
      Container failedContainerWidget = tester.widget(failedContainer);
      BoxDecoration failedContainerDecoration =
          failedContainerWidget.decoration as BoxDecoration;

      expect(failedContainerDecoration.color, Colors.transparent);
      expect(failedText.style?.color, onPrimaryContainerColor);

      await tester.tap(failed);
      await tester.pumpAndSettle();

      Finder refreshedFailed = find.text('Failed');
      Text refreshedFailedText = tester.widget<Text>(refreshedFailed);
      Finder refreshedFailedContainer = find
          .ancestor(of: refreshedFailed, matching: find.byType(Container))
          .first;
      Container refreshedFailedContainerWidget =
          tester.widget(refreshedFailedContainer);
      BoxDecoration refreshedFailedContainerDecoration =
          refreshedFailedContainerWidget.decoration as BoxDecoration;

      expect(refreshedFailedContainerDecoration.color, tertiaryColor);
      expect(refreshedFailedText.style?.color, onPrimaryColor);
    });

    testWidgets(
        'it changes the color of an active filter item box to transparent and the text color to on primary container when tapped',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'filters': jsonEncode({
          'statuses': ['failed'],
          'years': ['2006']
        })
      });

      await createWidgetUnderTest(tester);
      await tester.pumpAndSettle();

      Finder failed = find.text('Failed');
      Text failedText = tester.widget<Text>(failed);
      Finder failedContainer =
          find.ancestor(of: failed, matching: find.byType(Container)).first;
      Container failedContainerWidget = tester.widget(failedContainer);
      BoxDecoration failedContainerDecoration =
          failedContainerWidget.decoration as BoxDecoration;

      expect(failedContainerDecoration.color, tertiaryColor);
      expect(failedText.style?.color, onPrimaryColor);

      await tester.tap(failed);
      await tester.pumpAndSettle();

      Finder refreshedFailed = find.text('Failed');
      Text refreshedFailedText = tester.widget<Text>(refreshedFailed);
      Finder refreshedFailedContainer = find
          .ancestor(of: refreshedFailed, matching: find.byType(Container))
          .first;
      Container refreshedFailedContainerWidget =
          tester.widget(refreshedFailedContainer);
      BoxDecoration refreshedFailedContainerDecoration =
          refreshedFailedContainerWidget.decoration as BoxDecoration;

      expect(refreshedFailedContainerDecoration.color, Colors.transparent);
      expect(refreshedFailedText.style?.color, onPrimaryContainerColor);
    });

    testWidgets(
        'it will toggle the filters that are saved in the shared preferences on initial load',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'filters': jsonEncode({
          'statuses': ['failed'],
          'years': ['2006']
        })
      });

      await createWidgetUnderTest(tester);
      await tester.pumpAndSettle();

      Finder failed = find.text('Failed');
      Text failedText = tester.widget<Text>(failed);
      Finder failedContainer =
          find.ancestor(of: failed, matching: find.byType(Container)).first;
      Container failedContainerWidget = tester.widget(failedContainer);
      BoxDecoration failedContainerDecoration =
          failedContainerWidget.decoration as BoxDecoration;

      expect(failedContainerDecoration.color, tertiaryColor);
      expect(failedText.style?.color, onPrimaryColor);
    });

    testWidgets('it will toggle active filters', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'filters': jsonEncode({
          'statuses': ['failed'],
          'years': ['2006']
        })
      });

      await createWidgetUnderTest(tester);
      await tester.pumpAndSettle();

      Finder failed = find.text('Failed');
      Text failedText = tester.widget<Text>(failed);
      Finder failedContainer =
          find.ancestor(of: failed, matching: find.byType(Container)).first;
      Container failedContainerWidget = tester.widget(failedContainer);
      BoxDecoration failedContainerDecoration =
          failedContainerWidget.decoration as BoxDecoration;

      expect(failedContainerDecoration.color, tertiaryColor);
      expect(failedText.style?.color, onPrimaryColor);
    });
  });

  group('saving', () {
    setUp(() => SharedPreferences.setMockInitialValues({}));

    testWidgets('it will save selected filters when tapped on apply',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester);

      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      Finder failed = find.text('Failed');
      Finder year = find.text('2006');
      Finder apply = find.text('Apply');

      await tester.tap(failed);
      await tester.tap(year);
      await tester.tap(apply);
      await tester.pumpAndSettle();

      expect(
          preferences.getString('filters'),
          jsonEncode({
            'statuses': ['failed'],
            'years': ['2006']
          }));
    });

    testWidgets('it can save one type of selected filters when tapped on apply',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester);

      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      Finder year = find.text('2012');
      Finder apply = find.text('Apply');

      await tester.tap(year);
      await tester.tap(apply);
      await tester.pumpAndSettle();

      expect(
          preferences.getString('filters'),
          jsonEncode({
            'years': ['2012']
          }));
    });

    group('removing', () {
      setUp(() => SharedPreferences.setMockInitialValues({
            'filters': jsonEncode({
              'statuses': ['failed'],
              'years': ['2006']
            })
          }));

      testWidgets('it will remove all the filters by tapping on discard',
          (WidgetTester tester) async {
        await createWidgetUnderTest(tester);

        final SharedPreferences preferences =
            await SharedPreferences.getInstance();

        expect(
            preferences.getString('filters'),
            jsonEncode({
              'statuses': ['failed'],
              'years': ['2006']
            }));

        Finder discard = find.text('Discard');

        await tester.tap(discard);
        await tester.pumpAndSettle();

        expect(preferences.getString('filters'), null);
      });

      testWidgets(
          'it will remove all the filters by tapping the active filter items and tapping apply',
          (WidgetTester tester) async {
        await createWidgetUnderTest(tester);
        await tester.pumpAndSettle();

        final SharedPreferences preferences =
            await SharedPreferences.getInstance();

        expect(
            preferences.getString('filters'),
            jsonEncode({
              'statuses': ['failed'],
              'years': ['2006']
            }));

        Finder failed = find.text('Failed');
        Finder year = find.text('2006');
        Finder apply = find.text('Apply');

        await tester.tap(failed);
        await tester.tap(year);
        await tester.tap(apply);
        await tester.pumpAndSettle();

        expect(preferences.getString('filters'), null);
      });
    });
  });
}
