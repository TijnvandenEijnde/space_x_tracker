import 'dart:convert';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_x_tracker/project_theme.dart';
import 'package:space_x_tracker/providers/launch_provider.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/views/filter_view.dart';
import 'package:http/http.dart' as http;

import 'card_list_view_test.mocks.dart';
import 'launch_data.dart';

@GenerateMocks([http.Client])
void main() {
  final http.Client client = MockClient();
  final theme = ProjectTheme.lightTheme;
  final Color whiteColor = theme!.colorScheme.onPrimary;
  final Color blackColor = theme.colorScheme.onPrimaryContainer;
  final Color tertiaryColor = theme.colorScheme.tertiary;

  Future<void> createWidgetUnderTest(WidgetTester tester) async {
    Widget widgetUnderTest = ChangeNotifierProvider(
      create: (context) => LaunchProvider(),
      child: MaterialApp(
        home: FilterView(client: client),
        theme: ProjectTheme.lightTheme,
      ),
    );

    await tester.pumpWidget(widgetUnderTest);
  }

  group('filter', () {
    testWidgets(
        'it changes the color of the filter item box to tertiary and the text color to white when clicked',
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
      expect(failedText.style?.color, blackColor);

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
      expect(refreshedFailedText.style?.color, whiteColor);
    });

    testWidgets('it will save selected filters when clicked on save',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester);

      SharedPreferences.setMockInitialValues({});
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      Finder failed = find.text('Failed');

      Finder year = find.text('2006');

      Finder apply = find.text('Apply');

      await tester.tap(failed);
      await tester.pump();

      await tester.tap(year);
      await tester.pump();

      await tester.tap(apply);
      await tester.pumpAndSettle();

      Text failedText = tester.widget<Text>(failed);
      Text yearText = tester.widget<Text>(failed);

      expect(failedText.style?.color, whiteColor);
      expect(yearText.style?.color, whiteColor);
      expect(
          preferences.getString('filters'),
          jsonEncode({
            'statuses': ['failed'],
            'years': ['2006']
          }));
    });
  });
}
