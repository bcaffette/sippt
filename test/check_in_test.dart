import 'package:test/test.dart';
import 'package:sippt/check_in_rules.dart';

void main() {
  group('canCheckIn', () {
    test('~49 ft away can check in', () {
      bool validCheckIn = canCheckIn(
        42.350334150634914,
        -71.07923883695474,
        42.35030491231437,
        -71.07941653329625,
      );

      expect(validCheckIn, isTrue);
    });

    test('~53 ft away can check in', () {
      bool validCheckIn = canCheckIn(
        42.35030293005486,
        -71.0794299443409,
        42.35033464619956,
        -71.0792381664025,
      );

      expect(validCheckIn, isTrue);
    });

    test('far away cannot check in', () {
      // Pressed Cafe → Levain, ~1,568 ft
      bool validCheckIn = canCheckIn(
        42.34636707410132,
        -71.08115235400912,
        42.3503687549877,
        -71.0790114604389,
      );

      expect(validCheckIn, isFalse);
    });

    test('~56 ft away cannot check in', () {
      bool validCheckIn = canCheckIn(
        42.35030,
        -71.07940,
        42.3504535,
        -71.07940,
      );

      expect(validCheckIn, isFalse);
    });

    test('~54 ft away can check in', (){
      bool validCheckIn = canCheckIn(
        42.35030,
        -71.07940,
        42.35044802,
        -71.07940,
      );

      expect(validCheckIn, isTrue);
    });
  });
}
