import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../user_info_from_json.dart';

abstract class SecondPageBlocExt {
  const SecondPageBlocExt();
}

class SecondPageBlocEvent extends SecondPageBlocExt {
  final String searchName;
  const SecondPageBlocEvent(this.searchName);
}

class SecondPageBloc extends Bloc<SecondPageBlocExt, UsersInfo> {
  SecondPageBloc(UsersInfo initialState) : super(initialState) {
    on<SecondPageBlocEvent>((event, emit) async {
      if (!await Hive.boxExists('UserPageCache')) {
        await Hive.openBox('UserPageCache');
        UsersInfo _inf = await getEthData(event);
        emit(_inf);
      } else {
        await Hive.openBox('UserPageCache');
        if (Hive.box('UserPageCache').keys.contains(event.searchName)) {
          var box = Hive.box('UserPageCache');
          UsersInfo _inf = UsersInfo.fromJson(box.get(event.searchName));
          emit(_inf);
        } else {
          UsersInfo _inf = await getEthData(event);
          emit(_inf);
        }
      }
    });
  }

  Future<UsersInfo> getEthData(SecondPageBlocEvent event) async {
    var box = Hive.box('UserPageCache');
    try {
      var _url =
          "https://my-json-server.typicode.com/Tukorekt/TestEclipse/users"
          "?userName=${event.searchName}";
      var _response = await http.get(Uri.parse(_url));
      var _respMap = jsonDecode(_response.body);
      UsersInfo _inf = UsersInfo.fromJson(_respMap[0]);
      await box.put(event.searchName, _respMap[0]);
      return _inf;
    } catch (e) {
      return UsersInfo.error(e.toString());
    }
  }
}
