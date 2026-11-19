import 'package:sippt/models/check_in.dart';
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

    test('~54 ft away can check in', () {
      bool validCheckIn = canCheckIn(
        42.35030,
        -71.07940,
        42.35044802,
        -71.07940,
      );

      expect(validCheckIn, isTrue);
    });
  });

  group('CheckIn model', () {
    test('points represent a successful check in', () {
      final savedCheckIn = {
        'id': 'abcuuid',
        'user_id': 'xyz',
        'shop_id': 1,
        'pts_awarded': 5,
        'created_at': '2026-11-19T17:00:00Z',
      };

      final checkIn = CheckIn.fromJson(savedCheckIn);

      expect(checkIn.success, isTrue);
    });

    test('null points represent a failed check in', () {
      final savedCheckIn = {
        'id': 'abcuuid',
        'user_id': 'xyz',
        'shop_id': 1,
        'pts_awarded': null,
        'created_at': '2026-11-19T17:00:00Z',
      };

      final checkIn = CheckIn.fromJson(savedCheckIn);

      expect(checkIn.success, isFalse);
    });

    test('0 points represent a successful special check in', () {
      final savedCheckIn = {
        'id': 'abcuuid',
        'user_id': 'xyz',
        'shop_id': 1,
        'pts_awarded': 0,
        'created_at': '2026-11-19T17:00:00Z',
      };

      final checkIn = CheckIn.fromJson(savedCheckIn);

      expect(checkIn.success, isTrue);
    });

    test('check in date is parsing correctly to a datetime', () {
      final manualDate = DateTime.utc(2026, 11, 19, 17, 0, 0);
      final savedCheckIn = {
        'id': 'abcuuid',
        'user_id': 'xyz',
        'shop_id': 1,
        'pts_awarded': null,
        'created_at': '2026-11-19T17:00:00Z',
      };

      final checkIn = CheckIn.fromJson(savedCheckIn);

      expect(checkIn.createdAt, equals(manualDate));
    });

    test('fake check in throws a format error', () {
      final fakeCheckIn = {
        'id': 'abcuuid',
        'user_id': 'xyz',
        'pts_awarded': 1000,
        'created_at': '2026-11-19T17:00:00Z',
      };

      expect(
        () => CheckIn.fromJson(fakeCheckIn),
        throwsA(isA<FormatException>()),
      );
    });

    test('missing data is caught', () {
      final fakeCheckIn = {
        'id': 'abcuuid',
        'user_id': 'xyz',
        'shop_id': 1,
        'created_at': '2026-11-19T17:00:00Z',
      };

      expect(
        () => CheckIn.fromJson(fakeCheckIn),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
