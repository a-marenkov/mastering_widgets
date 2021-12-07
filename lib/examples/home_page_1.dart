import 'package:flutter/material.dart';

import '../common/tile_model.dart';
import '../common/tile_widget.dart';

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({Key? key}) : super(key: key);

  @override
  State<MyHomePage1> createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  final tiles = <TileViewModel>[
    TileViewModel(title: 'tile 1', time: DateTime.now()),
    TileViewModel(title: 'tile 2', time: DateTime.now()),
    TileViewModel(title: 'tile 3', time: DateTime.now()),
    TileViewModel(title: 'tile 4', time: DateTime.now()),
    TileViewModel(title: 'tile 5', time: DateTime.now()),
  ];

  void addTile({String? title, DateTime? time}) {
    setState(() {
      tiles.add(
        TileViewModel(
          title: title ?? 'no data',
          time: time ?? DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add tiles'),
      ),
      body: ListView(
        children: [
          for (final tile in tiles)
            TileWidget(
              viewModel: tile,
              key: ValueKey(tile),
            ),
        ],
      ),
      // body: ListView.builder(
      //   itemCount: tiles.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     final tile = tiles[index];
      //     return TileWidget(
      //       viewModel: tile,
      //       key: ValueKey(tile),
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTile,
        tooltip: 'add tile',
        child: const Icon(Icons.add),
      ),
    );
  }
}
