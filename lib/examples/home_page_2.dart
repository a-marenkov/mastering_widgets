import 'package:flutter/material.dart';

import '../common/sliver_persistent_child_delegate.dart';
import '../common/tile_model.dart';
import '../common/tile_widget.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key}) : super(key: key);

  @override
  State<MyHomePage2> createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Add tiles'),
            collapsedHeight: kToolbarHeight,
            expandedHeight: kToolbarHeight * 2.5,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: kToolbarHeight),
                  child: Icon(
                    Icons.flutter_dash,
                    size: 64.0,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final tile = tiles[index];
                return TileWidget(
                  viewModel: tile,
                  key: ValueKey(tile),
                );
              },
              childCount: tiles.length,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverPersistentChildDelegate(
              minHeight: kToolbarHeight,
              maxHeight: kToolbarHeight * 2,
              child: Container(
                color: Theme.of(context).primaryColor.withOpacity(0.85),
                child: Center(
                  child: Text(
                    'And again but grid',
                    style: Theme.of(context).primaryTextTheme.headline6,
                  ),
                ),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final tile = tiles[index];
                return TileWidget(
                  viewModel: tile,
                  key: ValueKey(tile),
                );
              },
              childCount: tiles.length,
            ),
          ),
          const SliverSafeArea(
            sliver: SliverToBoxAdapter(),
            top: false,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTile,
        tooltip: 'add tile',
        child: const Icon(Icons.add),
      ),
    );
  }
}
