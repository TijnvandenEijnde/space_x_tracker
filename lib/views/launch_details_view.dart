import 'package:flutter/material.dart';

class LaunchDetailsView extends StatefulWidget {
  const LaunchDetailsView({Key? key}) : super(key: key);

  static const routeName = '/launch-details';

  @override
  State<LaunchDetailsView> createState() => _LaunchDetailsViewState();
}

class _LaunchDetailsViewState extends State<LaunchDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        title: Text(
          'Launch details',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
