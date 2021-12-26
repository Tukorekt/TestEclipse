import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wind/album_page/album_page_bloc.dart';
import 'package:wind/all_albums_page/all_albums_page_class.dart';
import 'package:wind/comment_send_page/comment_send_page_class.dart';
import 'package:wind/main_page/first_page_bloc.dart';
import 'package:wind/post_page/post_page_class.dart';
import 'package:wind/user_page/user_page_bloc.dart';
import 'package:wind/user_page/user_page_class.dart';
import 'package:wind/user_info_from_json.dart';
import 'album_page/album_page_class.dart';
import 'all_posts_page/all_posts_page_class.dart';
import 'generated/l10n.dart';
import 'main_page/first_page_class.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void setUserName(String userName) => _userNameTrough = userName;

void setUserMap(Map userMap) => _userMap = userMap;

void setElementName(String elementName) => _elementName = elementName;

String _userNameTrough = '', _elementName = '';
Map _userMap = {};

void main() async {
  await Hive.initFlutter();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  BlocObserver blocObserver = Observer();
  runApp(MaterialApp(
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    debugShowCheckedModeBanner: false,
    routes: {
      "/first": (_) => First(),
      "/userPage": (_) => SecondPage(name: _userNameTrough),
      "/allPostsPage": (_) => AllPostsPage(map: _userMap),
      "/allAlbumsPage": (_) => AllAlbumsPage(map: _userMap),
      "/postPage": (_) => PostPage(postName: _elementName),
      "/albumPage": (_) => AlbumPage(albumName: _elementName, name: _userNameTrough),
      "/commentSendPage": (_) => CommentSendPage(name: _elementName)
    },
    home: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FirstPageBloc([])),
        BlocProvider(create: (_) =>
          SecondPageBloc(const UsersInfo('', '', '', '', '', {}, '', {}, {}))),
        BlocProvider(create: (_) => AlbumPageBloc({})),
      ],
      child: First(),
    ),
  ));
}

class Observer extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
