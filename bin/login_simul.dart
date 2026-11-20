import 'package:dotenv/dotenv.dart';
import 'package:sippt/models/check_in.dart';
import 'package:sippt/models/profile.dart';
import 'package:supabase/supabase.dart';

final env = DotEnv()..load();

Future<void> main() async {
  final SupabaseClient supabase = SupabaseClient(
    env['SUPABASE_URL']!,
    env['SUPABASE_PUBLISHABLE_KEY']!,
  );

  final res = await supabase.auth.signInWithPassword(email: env['SIMUL_EMAIL']!, password: env['SIMUL_PW']!);
  final uid = res.user!.id;

  final profileRaw = await supabase
      .from('profiles')
      .select()
      .eq('id', uid)
      .maybeSingle();
  
  final checkInRaw = await supabase
    .from('check_ins')
    .select()
    .maybeSingle();

  final profile = Profile.fromJson(profileRaw!);
  final checkIn = CheckIn.fromJson(checkInRaw!);

  print('Logged in as $profile');
  print('selected data: $checkIn');

  await supabase.dispose();
}
