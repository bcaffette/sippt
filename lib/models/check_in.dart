class CheckIn {
  final String id;
  final String userId;
  final int shopId;
  final int? ptsAwarded;
  final DateTime createdAt;

  CheckIn({
    required this.id,
    required this.userId,
    required this.shopId,
    required this.ptsAwarded,
    required this.createdAt,
  });

  bool get success => ptsAwarded != null;
}
