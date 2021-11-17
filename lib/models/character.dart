class Character {
  final String name, role;

  const Character({
    required this.name,
    required this.role,
  });

  Map<String, dynamic> toFirestoreMap() => {
        'name': name,
        'role': role,
      };
}
