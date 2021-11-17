class Club {
  final String id, name, description, gender, ownerId;
  final int members;
  final DateTime createdAt;

  const Club({
    required this.id,
    required this.ownerId,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.gender,
    required this.members,
  });

  Map<String, dynamic> toFirestoreMap() => {
        'name': name,
        'description': description,
        'gender': gender,
        'ownerId': ownerId,
        'createdAt': createdAt,
        'members': 0,
      };
}
