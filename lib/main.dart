import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:space_x_tracker/providers/launch_provider.dart';
import 'package:space_x_tracker/project_theme.dart';
import 'package:space_x_tracker/views/filter_view.dart';
import 'package:space_x_tracker/views/home_view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LaunchProvider(),
        )
      ],
      child: MaterialApp(
        title: 'SpaceX launch tracker',
          theme: ProjectTheme.lightTheme,
        home: HomeView(client: http.Client()),
        routes: {
          FilterView.routeName: (context) => const FilterView(),
        },
      ),
    );
  }
}
