import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:space_x_tracker/providers/models/launch_details_arguments.dart';
import 'package:space_x_tracker/providers/models/rocket.dart';
import 'package:space_x_tracker/providers/rocket_provider.dart';
import 'package:space_x_tracker/widgets/rocket/rocket_cover_image.dart';
import 'package:space_x_tracker/widgets/rocket/rocket_details_grid.dart';
import 'package:space_x_tracker/widgets/rocket/rocket_information_bar.dart';

import '../widgets/flash_message.dart';

class RocketDetailsView extends StatefulWidget {
  final http.Client client;

  const RocketDetailsView({
    Key? key,
    required this.client,
  }) : super(key: key);

  static const routeName = '/launch-details';

  @override
  State<RocketDetailsView> createState() => _RocketDetailsViewState();
}

class _RocketDetailsViewState extends State<RocketDetailsView> {
  Rocket? _rocket;
  Map<String, dynamic>? _rocketDetails;

  Future<void> _getRocket() async {
    final LaunchDetailsArguments arguments =
        ModalRoute.of(context)!.settings.arguments as LaunchDetailsArguments;

    await Provider.of<RocketProvider>(context, listen: false)
        .fetchRocket(widget.client, arguments.rocketId)
        .then((rocket) => setState(() {
              _rocket = rocket;
              _rocketDetails = rocket.rocketDetails;
            }))
        .catchError(
      (_) {
        FlashMessage.show(
          context: context,
          message: 'Unable to retrieve rocket',
        );

        Navigator.of(context).pop();
      },
    );
  }

  @override
  void didChangeDependencies() {
    _getRocket();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: _rocket == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.4,
                    child: Stack(
                      children: [
                        RocketCoverImage(imageUrl: _rocket?.flickrImages?.first),
                        RocketInformationBar(rocket: _rocket),
                        SafeArea(
                            child: BackButton(
                          color: colorScheme.onBackground,
                        ))
                      ],
                    ),
                  ),
                  RocketDetailsGrid(
                    rocket: _rocket,
                    rocketDetails: _rocketDetails,
                  ),
                ],
              ),
            ),
    );
  }
}
