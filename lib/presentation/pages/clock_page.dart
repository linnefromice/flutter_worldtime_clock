import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_worldtime_clock/data/model/time_info.dart';
import 'package:flutter_worldtime_clock/data/service/world_time_api.dart';
import 'package:flutter_worldtime_clock/presentation/widgets/clock_container.dart';
import 'package:flutter_worldtime_clock/presentation/widgets/clock_hands.dart';
import 'package:intl/intl.dart';

class TimeNotifier extends StateNotifier<DateTime> {
  TimeNotifier() : super(DateTime.now()) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      state = DateTime.now();
    });
  }
}
final timeProvider = StateProvider<DateTime>((ref) => DateTime.now());
final timezone = FutureProvider<TimeInfo?>((ref) async {
  return WorldTimeApi.getCurrentTime();
});

class ClockPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MaterialButton(
                padding: EdgeInsets.all(16.0),
                color: Colors.pink,
                shape: CircleBorder(),
                child: Icon(Icons.add),
                onPressed: () {},
              )
            ],
          ),
          Container(
            child: Consumer(
              builder: (context, watch, child) {
                final time = watch(timeProvider).state;
                return Column(
                  children: [
                    ClockContainer(
                      child: CustomPaint(
                        painter: ClockHands(time),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Consumer(
                      builder: (context, watch, child) {
                        final timeinfo = watch(timezone);
                        return timeinfo.when(
                          data: (timeinfo) => Text(
                            timeinfo?.timezone ?? '',
                            style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.w500,
                              fontSize: 24.0,
                            ),
                          ),
                          loading: () => const CircularProgressIndicator(),
                          error: (err, stack) => Container()
                        );
                      }
                    ),
                    Text(
                      DateFormat.Hm().format(time),
                      style: Theme.of(context).textTheme.headline2,
                    )
                  ],
                );
              },
            )
          )
        ],
      ),
    );
  }
}