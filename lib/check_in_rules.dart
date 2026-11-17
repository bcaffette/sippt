import 'package:sippt/geo.dart';

const checkInRadiusFt = 55; // add 5 for forgiveness

bool canCheckIn(
  double userLat,
  double userLong,
  double shopLat,
  double shopLong,
) {
  final double dist = distanceTo(userLat, userLong, shopLat, shopLong);
  return dist <= checkInRadiusFt;
}
