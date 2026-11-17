class Profile {
  final String id;
  final String username;
  final String? pfpUrl;
  final DateTime createdAt;

  Profile({
    required this.id,
    required this.username,
    this.pfpUrl,
    required this.createdAt,
  });

  factory Profile.fromJson(Map<String, dynamic> data) {
    // validate required fields before casting
    const requiredKeys = ['id', 'username', 'pfp_url', 'created_at'];
    const nonNullKeys = ['id', 'username', 'created_at'];
    for (final key in requiredKeys) {
      if (!data.containsKey(key)) {
        throw FormatException('Profile JSON missing "$key"');
      }
    }
    for (final key in nonNullKeys) {
      if (data[key] == null) {
        throw FormatException('Profile JSON "$key" field is null');
      }
    }

    return Profile(
      id: data['id'] as String,
      username: data['username'] as String,
      pfpUrl: data['pfp_url'] as String?,
      createdAt: DateTime.parse(data['created_at'] as String),
    );
  }
}
