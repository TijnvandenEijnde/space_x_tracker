import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_x_tracker/providers/launchProvider.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/widgets/card_list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Launch> launches = [];

  Future<void> _getLaunches() async {
    Provider.of<LaunchProvider>(context, listen: false).fetchLaunches().then(
        (_) => launches =
            Provider.of<LaunchProvider>(context, listen: false).allLaunches);
  }

  @override
  void initState() {
    _getLaunches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    launches = Provider.of<LaunchProvider>(context, listen: true).allLaunches;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Launches',
          style: TextStyle(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: launches.isEmpty == true
          ? const Placeholder()
          : Consumer<LaunchProvider>(builder: (context, launch, child) {
              return CardViewList(launches: launches);
            }),
    );
  }
}
