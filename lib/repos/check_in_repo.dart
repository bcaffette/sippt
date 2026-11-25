import 'package:sippt/models/check_in_response.dart';
import 'package:supabase/supabase.dart';

class CheckInRepo {
  final SupabaseClient client;

  CheckInRepo({required this.client});

  Future<CheckInResponse> checkIn(int shopId, double lat, double long) async {
    final res = await client.rpc(
      'check_in',
      params: {'p_shop_id': shopId, 'p_lat': lat, 'p_long': long},
    );

    return CheckInResponse.fromJson(res as Map<String, dynamic>);
  }
}
