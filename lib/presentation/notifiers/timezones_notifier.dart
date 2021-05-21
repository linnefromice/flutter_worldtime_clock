import 'package:flutter_worldtime_clock/data/service/world_time_api.dart';
import 'package:state_notifier/state_notifier.dart';

class TimezoneNotifier extends StateNotifier<List<String>> {
  TimezoneNotifier() : super([]) {
    state = [];
    _init();
  }

  void _init() async {
    state = await WorldTimeApi.getTimeZones() ?? [];
  }
}
