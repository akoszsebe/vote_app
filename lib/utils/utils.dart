import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class DarkRefreshIndicator extends RefreshIndicator {
  DarkRefreshIndicator({
    Key key,
    @required Widget child,
    double displacement = 40.0,
    @required RefreshCallback onRefresh,
    Color color = Colors.white,
    ScrollNotificationPredicate notificationPredicate =
        defaultScrollNotificationPredicate,
    String semanticsLabel,
    String semanticsValue,
  }) : super(
            key: key,
            child: child,
            displacement: displacement,
            onRefresh: onRefresh,
            color: color,
            backgroundColor: Colors.blueGrey[600],
            notificationPredicate: notificationPredicate,
            semanticsLabel: semanticsLabel,
            semanticsValue: semanticsValue);
}


Future<String> getDeviceDetails() async {
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId;
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor;//UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

return identifier;
}