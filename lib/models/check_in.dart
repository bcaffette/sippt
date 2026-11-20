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

  factory CheckIn.fromJson(Map<String, dynamic> data) {
    if (!data.containsKey('shop_id')) {
      throw FormatException('CheckIn JSON missing shop ID: $data');
    }

    if (!data.containsKey('pts_awarded')) {
      throw FormatException('CheckIn JSON missing points awarded. $data');
    }

    return CheckIn(
      id: data['id'] as String,
      userId: data['user_id'] as String,
      shopId: data['shop_id'] as int,
      ptsAwarded: data['pts_awarded'] as int?,
      questId: data['quest_id'] as String?,
      createdAt: DateTime.parse(data['created_at'] as String),
    );
  }
}
