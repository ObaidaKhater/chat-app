import 'package:flutter/cupertino.dart';

class RouteHelper {
  RouteHelper._();

  static RouteHelper routeHelper = RouteHelper._();
  GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  pushName(String routeName) {
    navKey.currentState.pushNamed(routeName);
  }

  pushReplacementNamed(String routeName) {
    navKey.currentState.pushReplacementNamed(routeName);
  }

  back() {
    navKey.currentState.pop();
  }
}
