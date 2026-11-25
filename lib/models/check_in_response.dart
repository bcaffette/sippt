class CheckInResponse {
  // because this is a response to the user, we don't need all the fields
  final bool success; // this tells the user if it was successful or not
  final double? distanceFt; // this lets the user know how close they were if they failed. doesn't neccessarily need to be there on success.
  final int? ptsAwarded; // this tells the user how many points they received. also doesn't need to be there

  CheckInResponse({
    required this.success,
    required this.distanceFt,
    required this.ptsAwarded
  });

  factory CheckInResponse.toJson(Map<String, dynamic> json){
    return CheckInResponse(
      success: json['success'], 
      distanceFt: json['distance_ft'], 
      ptsAwarded: json['pts_awarded']
    );
  }
}