import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/animated_visibility.dart';
import '../common/sliver_persistent_child_delegate.dart';
import '../common/tile_model.dart';
import '../common/tile_widget.dart';
import 'details_page.dart';

class TilesController extends ChangeNotifier {
  final tiles = <TileViewModel>[];

  void addTile({String? title, DateTime? time}) {
    tiles.add(
      TileViewModel(
        title: title ?? 'no data',
        time: time ?? DateTime.now(),
      ),
    );
    notifyListeners();
  }
}

class MyHomePage7 extends StatefulWidget {
  const MyHomePage7({Key? key}) : super(key: key);

  @override
  State<MyHomePage7> createState() => _MyHomePage7State();
}

class _MyHomePage7State extends State<MyHomePage7> {
  final textController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TilesController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add tiles'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: _MyAppBar(
              focusNode: focusNode,
              textController: textController,
            ),
          ),
        ),
        body: const _MyBody(),
        floatingActionButton: const _MyFab(),
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  final TextEditingController textController;
  final FocusNode focusNode;

  const _MyAppBar({
    required this.textController,
    required this.focusNode,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: _AddAction(
            textController: textController,
            onTap: () {
              final input = textController.value.text;
              textController.clear();
              focusNode.unfocus();
              // Provider.of<TilesController>(context, listen: false).addTile(title: input);
              context.read<TilesController>().addTile(title: input);
            },
          ),
        ),
      ],
    );
  }
}

class _AddAction extends StatefulWidget {
  final TextEditingController textController;
  final VoidCallback onTap;

  const _AddAction({
    required this.textController,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<_AddAction> createState() => _AddActionState();
}

class _AddActionState extends State<_AddAction> {
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    widget.textController.addListener(shouldToggle);
    shouldToggle();
  }

  @override
  void didUpdateWidget(covariant _AddAction oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.textController != widget.textController) {
      oldWidget.textController.removeListener(shouldToggle);
      widget.textController.addListener(shouldToggle);
    }
  }

  void shouldToggle() {
    var isEnabled = widget.textController.value.text.isNotEmpty;
    if (isEnabled != this.isEnabled) {
      setState(() {
        this.isEnabled = isEnabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isEnabled ? widget.onTap : null,
      icon: Icon(
        Icons.add,
        color: isEnabled
            ? Theme.of(context).backgroundColor
            : Theme.of(context).disabledColor,
      ),
    );
  }
}

class _MyBody extends StatefulWidget {
  const _MyBody({Key? key}) : super(key: key);

  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<_MyBody> {
  @override
  Widget build(BuildContext context) {
    final tilesController = context.watch<TilesController>();
    final tiles = tilesController.tiles;

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final tile = tiles[index];
              return TileWidget(
                viewModel: tile,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    DetailsPage.routeName,
                    arguments: tile,
                  );
                },
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
    );
  }
}

class _MyFab extends StatefulWidget {
  const _MyFab({Key? key}) : super(key: key);

  @override
  _MyFabState createState() => _MyFabState();
}

class _MyFabState extends State<_MyFab> {
  bool isVisible = false;
  ScrollController? controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = PrimaryScrollController.of(context);
    if (controller != this.controller) {
      this.controller?.removeListener(shouldToggle);
      this.controller = controller;
      this.controller?.addListener(shouldToggle);
    }
  }

  void shouldToggle() {
    var isVisible = false;
    final controller = this.controller;
    if (controller != null && controller.hasClients) {
      isVisible = controller.offset > 100;
    }
    if (isVisible != this.isVisible) {
      setState(() {
        this.isVisible = isVisible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedVisibility(
      duration: const Duration(milliseconds: 400),
      isVisible: isVisible,
      child: FloatingActionButton(
        onPressed: () {
          controller?.animateTo(
            0.0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeIn,
          );
        },
        tooltip: 'scroll up',
        child: const Icon(Icons.arrow_circle_up),
      ),
    );
  }
}
