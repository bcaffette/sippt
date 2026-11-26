import 'package:sippt/repos/quest_repo.dart';
import 'package:supabase/supabase.dart';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart';

void main() {
  late SupabaseClient supabase;
  late QuestRepo questRepo;

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
    questRepo = QuestRepo(client: supabase);
  });

  group('QuestRepo', () {
    test('earliest active quest expires at the next 4 AM reset', () async {
      final res = await questRepo.fetchActiveQuests();
      expect(res, isNotEmpty);

      final earliest = res
          .map((q) => q.expiresAt)
          .reduce((a, b) => a.isBefore(b) ? a : b);

      final now = DateTime.now();
      final today4am = DateTime(now.year, now.month, now.day, 4);
      final expected = now.isBefore(today4am)
          ? today4am // 12–4 AM: today
          : DateTime(
              now.year,
              now.month,
              now.day + 1,
              4,
            ); // otherwise: tomorrow

      expect(
        earliest.isAtSameMomentAs(expected),
        isTrue,
        reason: 'Earliest expiry was $earliest, expected $expected',
      );
    });
  });
}