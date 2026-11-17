import 'package:test/test.dart';
import 'package:sippt/geo.dart';

void main () {
  group('distanceTo', () {
    test('same location returns 0 distance', () {
      final double dist = distanceTo(42, -71, 42, -71);
      expect(dist, equals(0));
    });

    test('distance of two real places matches', () {
      final double dist = distanceTo(42.34636707410132, -71.08115235400912, 42.3503687549877, -71.0790114604389);
      expect(dist, closeTo(1568.24, 50)); // room for error
    });

    test('distance just within 50 feet', () {
      final double dist = distanceTo(42.350334150634914, -71.07923883695474, 42.35030491231437, -71.07941653329625);
      expect(dist, closeTo(50, 5));
      expect(dist, lessThan(50));
    });

    test('distance just outside 50 feet', () {
      final double dist = distanceTo(42.35030293005486, -71.0794299443409, 42.35033464619956, -71.0792381664025);
      expect(dist, closeTo(50, 5));
      expect(dist, greaterThan(50));
    });
  });
}