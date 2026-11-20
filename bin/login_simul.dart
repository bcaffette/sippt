import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';

final env = DotEnv()..load();

Future<void> main() async {
  final SupabaseClient supabase = SupabaseClient(
    env['SUPABASE_URL']!,
    env['SUPABASE_PUBLISHABLE_KEY']!,
  );

  final res = await supabase.auth.signInWithPassword(
    email: env['SIMUL_EMAIL']!,
    password: env['SIMUL_PW']!,
  );

  final outOfRangeCheckInAttempt = await supabase.rpc(
    'check_in',
    params: {
      'p_shop_id': 2,
      'p_lat': 42.3472112246437,
      'p_long': -71.0821246180607,
    },
  );

  final atLocation = await supabase.rpc(
    'check_in',
    params: {
      'p_shop_id': 2,
      'p_lat': 42.3470577246437,
      'p_long': -71.0821246180607,
    },
  );

  final atLocationAfterQuestComplete = await supabase.rpc(
    'check_in',
    params: {
      'p_shop_id': 2,
      'p_lat': 42.3470577246437,
      'p_long': -71.0821246180607,
    },
  );

  print('Out of range check in attempt: $outOfRangeCheckInAttempt');
  print('At location for successful check in: $atLocation');
  print(
    'Already completed quest, but grabbing an evening coffee: $atLocationAfterQuestComplete',
  );

  await supabase.dispose();
}
