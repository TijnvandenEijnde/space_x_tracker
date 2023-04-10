import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/widgets/icon_row_item.dart';
import 'package:space_x_tracker/widgets/launch_card.dart';

import 'launch_data.dart';

void main() {
  final Launch launch = LaunchData.failedLaunch;
  const Color errorColor = Color(0xffd32f2f);
  const Color successColor = Color(0xFF39DC03);
  const Color primaryColor = MaterialColor(0xff2196f3, {});

  Future<void> createWidgetUnderTest(WidgetTester tester, Launch launch) async {
    Widget widgetUnderTest = MaterialApp(home: LaunchCard(launch: launch));
    await mockNetworkImagesFor(() => tester.pumpWidget(widgetUnderTest));
  }

  group('display', () {
    testWidgets('it displays the correct data on the card',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester, launch);

      Finder image = find.byWidgetPredicate((Widget widget) =>
          widget is Image && widget.key == ValueKey('patch-${launch.id}'));
      Finder flightNumber = find.text('#${launch.flightNumber.toString()}');
      Finder name = find.text(launch.name!);
      Finder failed = find.text('FAILED');
      Finder date = find.text(
        DateFormat('MMM d y, h:mm:ss a').format(launch.dateLocal!),
      );
      Finder icons = find.byType(IconRowItem);
      IconRowItem crew = tester.widget(icons.first);

      expect(image, findsOneWidget);
      expect(image.toString().contains(launch.links!.patch!.small!), true);

      expect(flightNumber, findsOneWidget);
      expect(name, findsOneWidget);
      expect(failed, findsOneWidget);
      expect(date, findsOneWidget);

      expect(icons, findsNWidgets(4));
      expect(crew.count, launch.crew!.length.toString());
      expect(crew.icon, Icons.person);
    });

    testWidgets('it displays a text widget with a rocket when patch data is null',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester, LaunchData.upcomingLaunch);

      Finder image = find.byWidgetPredicate((Widget widget) =>
      widget is Image && widget.key == ValueKey('patch-${LaunchData.upcomingLaunch.id}'));
      Finder rocket = find.text('🚀');
      Text rocketTextWidget = tester.widget(rocket);

      expect(image, findsNothing);
      expect(rocket, findsOneWidget);
      expect(rocketTextWidget.style?.fontSize, 50);
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
        'it should change the status to upcoming and the color to the primary color when upcoming data is true',
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
      expect(statusTextWidget.style?.color?.value, primaryColor.value);
      expect(card, findsOneWidget);
      expect(borderColor.value, primaryColor.value);
    });
  });
}
