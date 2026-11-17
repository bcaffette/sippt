import 'package:dotenv/dotenv.dart';
import 'package:sippt/profile.dart';
import 'package:sippt/repos/leaderboard_repo.dart';
import 'package:supabase/supabase.dart';

final env = DotEnv()..load();

Future<void> main() async {
  final SupabaseClient supabase = SupabaseClient(
    env['SUPABASE_URL']!,
    env['SUPABASE_PUBLISHABLE_KEY']!,
  );

  final lbRepo = LeaderboardRepo(client: supabase);

  final List<Profile> lb = await lbRepo.getLeaderboardAll();

  for (final profile in lb) {
    print(profile.username);
  }

  await supabase.dispose();
}
