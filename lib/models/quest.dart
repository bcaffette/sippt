class Quest {
  final String id;
  final int shopId;
  final int value;
  final DateTime expiresAt;

  Quest({
    required this.id,
    required this.shopId,
    required this.value,
    required this.expiresAt,
  });

  factory Quest.fromJson(Map<String, dynamic> json) {
    return Quest(
      id: json['id'] as String,
      shopId: json['shop_id'] as int,
      value: json['value'] as int,
      expiresAt: DateTime.parse(json['expires_at'] as String),
    );
  }
}
