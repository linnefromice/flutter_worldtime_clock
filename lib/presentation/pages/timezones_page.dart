import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_worldtime_clock/data/model/time_info.dart';
import 'package:flutter_worldtime_clock/data/service/world_time_api.dart';
import 'package:flutter_worldtime_clock/presentation/notifiers/clocks_notifier.dart';
import 'package:flutter_worldtime_clock/presentation/notifiers/timezones_notifier.dart';

final timezonesProvider = StateNotifierProvider((ref) => TimezoneNotifier());

class TimezonesPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TimezonesPage> {
  String? _timezone;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select timezone'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Consumer(
          builder: (context, watch, child) {
            final timezones = watch(timezonesProvider);
            final provider = watch(clocksProvider);
            if (timezones != null) {
              return Column(
                children: [
                  DropdownSearch<String>(
                    showSearchBox: true,
                    onChanged: (tz) => setState(() => _timezone = tz),
                    items: timezones,
                    mode: Mode.MENU,
                    selectedItem: _timezone,
                  ),
                  ElevatedButton(
                    child: _loading ? CircularProgressIndicator() : Text("Add"),
                    onPressed: _loading
                      ? null
                      : () async {
                        if (_timezone == null) return;
                        setState(() {
                          _loading = true;
                        });
                        TimeInfo? info = await WorldTimeApi.getTimezoneTime(_timezone!);
                        context.read(provider).add(info);
                        setState(() {
                          _loading = false;
                        });
                        Navigator.pop(context);
                      }
                  )
                ],
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}