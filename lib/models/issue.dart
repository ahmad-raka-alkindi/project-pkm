class Issue {
  Issue({
    required this.title,
    required this.category,
    required this.location,
    required this.description,
    required this.date,
    this.status = 'Menunggu',
  });

  final String title;
  final String category;
  final String location;
  final String description;
  final DateTime date;
  final String status;
}
