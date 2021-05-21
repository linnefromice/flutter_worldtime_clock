import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_worldtime_clock/data/model/time_info.dart';
import 'package:state_notifier/state_notifier.dart';

class ClocksNotifier extends StateNotifier<List<TimeInfo>> {
  ClocksNotifier() : super([]);

  void add(TimeInfo clock) {
    state.add(clock);
  }

  void remove(TimeInfo clock) {
    state.remove(clock);
  }
}

final clocksProvider = StateNotifierProvider((ref) => ClocksNotifier());