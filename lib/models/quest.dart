class Quest {
  final int shopId;
  final String shopName;
  final int value;
  final DateTime expiresAt;

  Quest({
    required this.shopId,
    required this.shopName,
    required this.value,
    required this.expiresAt,
  });

  factory Quest.fromJson(Map<String, dynamic> json) {
    return Quest(
      shopId: json['shop_id'] as int,
      shopName: json['shops']['name'] as String,
      value: json['value'] as int,
      expiresAt: DateTime.parse(json['expires_at'] as String),
    );
  }
}
