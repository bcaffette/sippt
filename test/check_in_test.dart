import 'package:sippt/repos/check_in_repo.dart';
import 'package:supabase/supabase.dart';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart';

const shopId = 2;
const atShop = (lat: 42.34709344608289, long: -71.08213177258727);
const outsideRadius = (lat: 42.34799990038408, long: -71.08270281446373);

void main() {
  late SupabaseClient supabase;
  late CheckInRepo checkInRepo;

  setUpAll(() async {
    final env = DotEnv()..load();
    supabase = SupabaseClient(
      env['SUPABASE_URL']!,
      env['SUPABASE_PUBLISHABLE_KEY']!,
    );
    await supabase.auth.signInWithPassword(
      email: env['SIMUL_EMAIL']!,
      password: env['SIMUL_PW']!,
    );
    checkInRepo = CheckInRepo(client: supabase);
  });

  tearDownAll(() => supabase.dispose());

  group('CheckInRepo', () {
    test('within 50 ft - successful check in', () async {
      final res = await checkInRepo.checkIn(shopId, atShop.lat, atShop.long);

      expect(res.success, isTrue);
      expect(res.distanceFt, lessThan(50));
    });

    test('outside 50 ft - unsuccessful, no points', () async {
      final res = await checkInRepo.checkIn(
        shopId,
        outsideRadius.lat,
        outsideRadius.long,
      );

      expect(res.success, isFalse);
      expect(res.distanceFt, greaterThan(50));
      expect(res.ptsAwarded, isNull);
    });
  });
}
