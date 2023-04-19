import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_x_tracker/custom_color_scheme.dart';
import 'package:space_x_tracker/providers/launch_provider.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/views/filter_view.dart';
import 'package:space_x_tracker/widgets/home/card_list_view.dart';
import 'package:http/http.dart' as http;
import 'package:space_x_tracker/widgets/flash_message.dart';
import 'package:space_x_tracker/widgets/home/no_launch_results_message.dart';
import 'package:space_x_tracker/widgets/home/searching/launch_search_delegate.dart';
import 'package:space_x_tracker/widgets/home/sorting/sorting_bottom_sheet.dart';

class HomeView extends StatefulWidget {
  final http.Client client;

  const HomeView({
    Key? key,
    required this.client,
  }) : super(key: key);

  static const routeName = '/';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Launch> launches = [];
  bool loading = true;

  Future<void> _getLaunches() async {
    await Provider.of<LaunchProvider>(
      context,
      listen: false,
    ).fetchLaunches(widget.client).then(
      (_) {
        if (loading == false) {
          FlashMessage.show(
              context: context,
              color: Theme.of(context).colorScheme.success,
              message: 'Refreshed the launches');
        }

        if (loading == true) {
          setState(() => loading = false);
        }
      },
    ).catchError(
      (_) {
        FlashMessage.show(
            context: context, message: 'Unable to retrieve launches');
        setState(() => loading = false);
      },
    );
  }

  @override
  void initState() {
    _getLaunches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    launches = Provider.of<LaunchProvider>(context, listen: true).allLaunches;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Launches',
          style: TextStyle(
            color: colorScheme.background,
          ),
        ),
        backgroundColor: colorScheme.primary,
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: colorScheme.background,
            ),
            onPressed: () => _getLaunches(),
          ),
          IconButton(
            icon: Icon(
              Icons.swap_vert,
              color: colorScheme.background,
            ),
            onPressed: () => Provider.of<LaunchProvider>(context, listen: false)
                .reverseLaunches(),
          ),
          IconButton(
            icon: Icon(
              Icons.sort,
              color: colorScheme.background,
            ),
            onPressed: () => showModalBottomSheet(
              backgroundColor: colorScheme.onPrimary,
              context: context,
              builder: (BuildContext context) {
                return const SortingBottomSheet();
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.filter_alt,
              color: colorScheme.background,
            ),
            onPressed: () =>
                Navigator.of(context).pushNamed(FilterView.routeName),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: colorScheme.background,
            ),
            onPressed: () => showSearch(
              context: context,
              delegate: LaunchSearchDelegate(
                launches: launches,
              ),
            ),
          ),
        ],
      ),
      body: launches.isEmpty == true
          ? Provider.of<LaunchProvider>(context).filtered == true
              ? const NoLaunchResultsMessage(
                  subText: 'There are no launches matching these filters.',
                )
              : loading == false
                  ? const NoLaunchResultsMessage(
                      subText:
                          'We are unable to retrieve the launches at the moment, try the refresh button or came back at a later time.',
                    )
                  : const Center(child: CircularProgressIndicator())
          : Consumer<LaunchProvider>(builder: (context, launch, child) {
              return CardViewList(
                launches: launches,
              );
            }),
    );
  }
}
