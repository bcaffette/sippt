class CheckInResponse {
  final bool success;
  final double? distanceFt;
  final int? ptsAwarded;

  CheckInResponse({
    required this.success,
    required this.distanceFt,
    required this.ptsAwarded,
  });

  factory CheckInResponse.fromJson(Map<String, dynamic> json) {
    return CheckInResponse(
      success: json['success'] as bool,
      distanceFt: (json['distance_ft'] as num?)?.toDouble(),
      ptsAwarded: json['pts_awarded'] as int?,
    );
  }
}
