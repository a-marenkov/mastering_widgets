import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../common/tile_model.dart';
import '../common/tile_widget.dart';

class DetailsPage extends StatelessWidget {
  final TileViewModel model;

  static const routeName = 'details_page';

  const DetailsPage({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tile\'s details'),
      ),
      body: Center(
        child: TileWidget(
          viewModel: model,
        ),
      ),
    );
  }
}
