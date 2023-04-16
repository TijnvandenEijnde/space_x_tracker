import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:space_x_tracker/providers/models/launch_details_arguments.dart';
import 'package:space_x_tracker/providers/models/rocket.dart';
import 'package:space_x_tracker/providers/rocket_provider.dart';

import '../widgets/flash_message.dart';

class LaunchDetailsView extends StatefulWidget {
  final http.Client client;

  const LaunchDetailsView({
    Key? key,
    required this.client,
  }) : super(key: key);

  static const routeName = '/launch-details';

  @override
  State<LaunchDetailsView> createState() => _LaunchDetailsViewState();
}

class _LaunchDetailsViewState extends State<LaunchDetailsView> {
  Rocket? _rocket;

  Future<void> _getRocket() async {
    final LaunchDetailsArguments arguments =
        ModalRoute.of(context)!.settings.arguments as LaunchDetailsArguments;

    await Provider.of<RocketProvider>(context, listen: false)
        .fetchRocket(widget.client, arguments.rocketId)
        .then((rocket) => setState(() => _rocket = rocket));
  }

  @override
  void didChangeDependencies() {
    _getRocket();
    super.didChangeDependencies();
  }

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
      body: _rocket == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Text(_rocket!.name!),
                ],
              ),
            ),
    );
  }
}
