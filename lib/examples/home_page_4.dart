import 'package:flutter/material.dart';

import '../common/sliver_persistent_child_delegate.dart';
import '../common/tile_model.dart';
import '../common/tile_widget.dart';

class MyHomePage4 extends StatefulWidget {
  const MyHomePage4({Key? key}) : super(key: key);

  @override
  State<MyHomePage4> createState() => _MyHomePage4State();
}

class _MyHomePage4State extends State<MyHomePage4> {
  final tiles = <TileViewModel>[
    TileViewModel(title: 'tile 1', time: DateTime.now()),
    TileViewModel(title: 'tile 2', time: DateTime.now()),
    TileViewModel(title: 'tile 3', time: DateTime.now()),
    TileViewModel(title: 'tile 4', time: DateTime.now()),
    TileViewModel(title: 'tile 5', time: DateTime.now()),
  ];
  final scrollController = ScrollController();
  final textController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    scrollController.dispose();
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: textController,
                    focusNode: focusNode,
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                    cursorColor: Theme.of(context).backgroundColor,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).backgroundColor,
                      focusColor: Theme.of(context).backgroundColor,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).backgroundColor,
                          width: 4.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: textController,
                  builder: (context, listenable, child) {
                    return IconButton(
                      onPressed: listenable.text.isEmpty
                          ? null
                          : () {
                              final input = textController.value.text;
                              textController.clear();
                              focusNode.unfocus();
                              addTile(title: input);
                            },
                      icon: Icon(
                        Icons.add,
                        color: listenable.text.isNotEmpty
                            ? Theme.of(context).backgroundColor
                            : Theme.of(context).disabledColor,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
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
              minHeight: 60.0,
              maxHeight: 120.0,
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
      floatingActionButton: AnimatedBuilder(
        animation: scrollController,
        builder: (BuildContext context, Widget? child) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            opacity: (scrollController.offset > 100) ? 1.0 : 0.0,
            child: IgnorePointer(
              ignoring: (scrollController.offset < 100),
              child: FloatingActionButton(
                onPressed: () {
                  scrollController.animateTo(
                    0.0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                  );
                },
                tooltip: 'scroll up',
                child: const Icon(Icons.arrow_circle_up),
              ),
            ),
          );
        },
      ),
    );
  }
}
