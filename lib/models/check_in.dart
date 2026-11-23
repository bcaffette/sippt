class CheckIn {
  final String id;
  final String userId;
  final int shopId;
  final int? ptsAwarded;
  final String? questId;
  final DateTime createdAt;

  CheckIn({
    required this.id,
    required this.userId,
    required this.shopId,
    required this.ptsAwarded,
    required this.questId,
    required this.createdAt,
  });

  bool get success => ptsAwarded != null;

  factory CheckIn.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'user_id': String userId,
        'shop_id': int shopId,
        'pts_awarded': int? ptsAwarded,
        'created_at': String createdAt,
      } =>
        CheckIn(
          id: id,
          userId: userId,
          shopId: shopId,
          ptsAwarded: ptsAwarded,
          questId: json['quest_id'] as String?,
          createdAt: DateTime.parse(createdAt),
        ),
      _ => throw FormatException('Invalid CheckIn JSON: $json'),
    };
  }
}
