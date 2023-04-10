import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/widgets/icon_row_item.dart';
import 'package:space_x_tracker/widgets/launch_card.dart';

import 'launch_data.dart';

void main() {
  final Launch launch = LaunchData.launch.first;

  Future<void> createWidgetUnderTest(WidgetTester tester) async {
    Widget widgetUnderTest = MaterialApp(home: LaunchCard(launch: launch));
    await mockNetworkImagesFor(() => tester.pumpWidget(widgetUnderTest));
  }

  testWidgets('it displays the correct data on the card',
      (WidgetTester tester) async {
    await createWidgetUnderTest(tester);

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

  });
}
