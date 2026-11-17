import 'package:sippt/profile.dart';
import 'package:supabase/supabase.dart';

class LeaderboardRepo {
  final SupabaseClient client;

  LeaderboardRepo({required this.client});

  Future<List<Profile>> getLeaderboardAll() async {
    final List<Profile> lb = [];

    final rows = await client.from('profiles').select();

    for (final p in rows) {
      final profile = Profile.fromJson(p);
      lb.add(profile);
    }

    return lb;
  }
}
