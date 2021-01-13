import 'package:flutter/material.dart';
import 'package:qurbani/screens/dashboard/user/dashboard.dart';
import 'package:qurbani/screens/requests/user/requests.dart';

class AuthNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String routeName;

  AuthNavigator({this.navigatorKey, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: 'dashboard',
      onGenerateRoute: (routeSetting){
        return _getRoute(routeSetting);
      },
    );
  }

  MaterialPageRoute<dynamic> _getRoute(RouteSettings routeSettings){
    print('ROUTE CHANGING');
    switch(routeSettings.name){
      case 'dashboard':
        return MaterialPageRoute(
          settings: RouteSettings(name: 'dashbaord'),
          builder: (context) => Dashboard()
        );

      case 'requests':
        return MaterialPageRoute(
            settings: RouteSettings(name: 'requests'),
            builder: (context) => Requests()
        );

      default:
        return MaterialPageRoute(
            settings: RouteSettings(name: 'feedback'),
            builder: (context) => Requests()
        );
    }
  }

}
