import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ranger/pages/homepage.dart';
import 'package:ranger/pages/q_info/q_info.dart';
import 'package:ranger/pages/rooms/rooms.dart';
import 'package:ranger/pages/settings/settings.dart';

import '../pages/automations/searching/search_words.dart';
import '../pages/devices/bloc/device_bloc.dart';
import '../pages/devices/device.dart';
import '../pages/q_info/bloc/q_info_bloc.dart';

class AppRoutes {
  static const homepage = '/';
  static const info = '/info';
  static const mobScan = '/scan';
  static const brScan = '/scanner';
  static const device = '/device';
  static const rooms = '/rooms';
  static const automations = '/automations';
  static const settings = '/setting';
  

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    if (settings.arguments != null) {}

    var routes = <String, WidgetBuilder>{
      AppRoutes.homepage: (context) => const HomePage(
            title: '',
          ),
      AppRoutes.info: (context) => BlocProvider(
            create: (context) => QrInfoBloc(),
            child: Information(),
          ),
      AppRoutes.device: (context) => BlocProvider(
            create: (context) => DeviceBloc(),
            child: Device(),
          ),

      AppRoutes.rooms: (context) => Rooms(),
      AppRoutes.automations: (context) => SearchWords(),
      AppRoutes.settings: (context) => Settings()
    };

    WidgetBuilder builder = routes[settings.name] ?? routes.values.first;
    return MaterialPageRoute(builder: (ctx) => builder(ctx));
  }
}

class PageArguments {
  final String? pageTitle;
  final Map<String, dynamic>? data;

  PageArguments({
    this.pageTitle,
    this.data,
  });
}
