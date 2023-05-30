class Assignment {
  final int id;
  final String name;

  Assignment({
    required this.id,
    required this.name,
  });

  factory Assignment.getAssignment(Map data) {
    return Assignment(
      id: data['id'],
      name: data['name'],
    );
  }
}
