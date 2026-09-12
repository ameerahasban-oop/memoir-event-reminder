class Event {
  final String name;
  final DateTime date;
  final String location;
  final String? imagePath;
  final bool isFavorite;

  Event({
    required this.name,
    required this.date,
    required this.location,
    this.imagePath,
    this.isFavorite = false,
  });
}