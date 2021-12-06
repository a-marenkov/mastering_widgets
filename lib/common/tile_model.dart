class TileViewModel {
  final String title;
  final DateTime time;

  const TileViewModel({
    required this.title,
    required this.time,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TileViewModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          time == other.time;

  @override
  int get hashCode => title.hashCode ^ time.hashCode;

  @override
  String toString() => 'TileViewModel{title: $title, time: $time}';
}
