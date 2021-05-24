import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_worldtime_clock/data/model/time_info.dart';

class WorldTimeApi {
  static final domain = "worldtimeapi.org";

  static Future<TimeInfo?> getCurrentTime() async {
    http.Response res = await http.get(Uri.http(domain, "api/ip"));
    if (res.statusCode == 200) {
      return TimeInfo.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }

  static Future<TimeInfo?> getTimezoneTime(String timeZone) async {
    http.Response res = await http.get(Uri.http(domain, "api/timezone/$timeZone"));
    if (res.statusCode == 200) {
      return TimeInfo.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }

  static Future<List<String>?> getTimeZones() async {
    http.Response res = await http.get(Uri.http(domain, "api/timezone"));
    if (res.statusCode == 200) {
      return List<String>.from(jsonDecode(res.body));
    } else {
      return null;
    }
  }
}
