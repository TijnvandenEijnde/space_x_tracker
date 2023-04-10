import 'package:flutter/material.dart';
import 'package:space_x_tracker/providers/launch_provider.dart';
import 'package:space_x_tracker/views/home_view.dart';
import 'package:provider/provider.dart';

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
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueAccent,
          ),
        ),
        home: const HomeView(),
      ),
    );
  }
}
