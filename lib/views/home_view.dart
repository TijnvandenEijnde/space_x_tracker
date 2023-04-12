import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_x_tracker/providers/launch_provider.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/widgets/card_list_view.dart';
import 'package:http/http.dart' as http;
import 'package:space_x_tracker/widgets/flash_message.dart';
import 'package:space_x_tracker/widgets/launch_search_delegate.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Launch> launches = [];

  Future<void> _getLaunches() async {
    await Provider.of<LaunchProvider>(context, listen: false)
        .fetchLaunches()
        .catchError(
          (_) => FlashMessage.show(
              context: context, message: 'Unable to retrieve data'),
        );
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.sort,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () => showModalBottomSheet(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              context: context,
              builder: (BuildContext context) {
                return const SortingBottomSheet();
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.filter_alt,
              color: Theme.of(context).colorScheme.background,
            ),
            onPressed: () =>
                Navigator.of(context).pushNamed(FilterView.routeName),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.background,
            ),
            onPressed: () => showSearch(
                context: context,
                delegate: LaunchSearchDelegate(launches: launches)),
          )
        ],
      ),
      body: launches.isEmpty == true
          ? const Center(child: CircularProgressIndicator())
          : Consumer<LaunchProvider>(builder: (context, launch, child) {
              return CardViewList(
                client: http.Client(),
                launches: launches,
              );
            }),
    );
  }
}
