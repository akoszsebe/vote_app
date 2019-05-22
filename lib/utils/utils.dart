import 'package:flutter/material.dart';

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
    Color backgroundColor = Colors.blueGrey,
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
            backgroundColor: Colors.blueGrey,
            notificationPredicate: notificationPredicate,
            semanticsLabel: semanticsLabel,
            semanticsValue: semanticsValue);
}
