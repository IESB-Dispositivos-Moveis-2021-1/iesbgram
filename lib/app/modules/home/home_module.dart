import 'package:flutter_modular/flutter_modular.dart';
import 'package:iesbgram/app/constants.dart';
import 'package:iesbgram/app/modules/feed/feed_module.dart';
import 'package:iesbgram/app/modules/profile/profile_module.dart';
import 'package:iesbgram/app/modules/search/search_module.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => HomePage(),
      children: [
        ModuleRoute(Constants.Routes.FEED, module: FeedModule(), transition: TransitionType.fadeIn),
        ModuleRoute(Constants.Routes.SEARCH, module: SearchModule(), transition: TransitionType.fadeIn),
        ModuleRoute(Constants.Routes.PROFILE, module: ProfileModule(), transition: TransitionType.fadeIn),
      ]
    ),
  ];
}
