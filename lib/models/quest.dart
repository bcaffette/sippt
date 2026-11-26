class Quest {
  final int partnerId;
  final String partnerName;
  final int value;
  final DateTime expiresAt;

  Quest({
    required this.partnerId,
    required this.partnerName,
    required this.value,
    required this.expiresAt,
  });

  factory Quest.fromJson(Map<String, dynamic> json) {
    return Quest(
      partnerId: json['partner_id'] as int,
      partnerName: json['partners']['name'] as String,
      value: json['value'] as int,
      expiresAt: DateTime.parse(json['expires_at'] as String),
    );
  }
}
