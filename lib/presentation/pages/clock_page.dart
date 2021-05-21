import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_worldtime_clock/data/model/time_info.dart';
import 'package:flutter_worldtime_clock/data/service/world_time_api.dart';
import 'package:flutter_worldtime_clock/presentation/widgets/clock_container.dart';
import 'package:flutter_worldtime_clock/presentation/widgets/clock_hands.dart';
import 'package:intl/intl.dart';

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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
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
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(height: 10.0)
                    ],
                  );
                },
              )
            ),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Card(
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "New York, USA",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                            )
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            "+3HRS | EST",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            DateFormat.jm().format(DateTime.now()),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                        ],
                      ),
                    )
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}