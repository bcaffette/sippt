class Profile {
  final String id;
  final String username;
  final String? pfpUrl;
  final DateTime createdAt;

  Profile({
    required this.id,
    required this.username,
    required this.pfpUrl,
    required this.createdAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'username': String username,
        'pfp_url': String? pfpUrl,
        'created_at': String createdAt,
      } =>
        Profile(
          id: id,
          username: username,
          pfpUrl: pfpUrl,
          createdAt: DateTime.parse(createdAt),
        ),
      _ => throw FormatException('Invalid Profile JSON: $json'),
    };
  }
}
