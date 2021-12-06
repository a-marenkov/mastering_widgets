import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'tile_model.dart';

class TileWidget extends StatelessWidget {
  final TileViewModel viewModel;
  final VoidCallback? onTap;

  const TileWidget({
    required this.viewModel,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(viewModel.title),
        subtitle: Text(viewModel.time.toString()),
        onTap: onTap ??
            () {
              print(viewModel.toString());
            },
      ),
    );
  }
}
