import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../users_list_from_json.dart';

abstract class FirstPageBlocExt {
  const FirstPageBlocExt();
}

class FirstPageBlocEvent extends FirstPageBlocExt {
  const FirstPageBlocEvent();
}

class FirstPageBloc extends Bloc<FirstPageBlocExt, List> {
  FirstPageBloc(List initialState) : super(initialState) {
    on<FirstPageBlocEvent>((event, emit) async {
      if (await Hive.boxExists('FirstPageCache')){
        await Hive.openBox('FirstPageCache');
        var _box = Hive.box('FirstPageCache');
        List<UsersList> _usersList = [];
        for (var _usersMap in _box.values) {
          _usersList.add(UsersList.fromCache(_usersMap));
        }
        emit(_usersList);
      } else {
        await Hive.openBox('FirstPageCache');
        var _box = Hive.box('FirstPageCache');
        try {
          String _url =
              "https://my-json-server.typicode.com/Tukorekt/TestEclipse/usersList";
          var _response = await http.get(Uri.parse(_url));
          var _respMap = jsonDecode(_response.body);
          List<UsersList> usersList = [];
          for (var usersMap in _respMap) {
            usersList.add(UsersList.fromJson(usersMap));
            await _box.add(UsersList.fromJson(usersMap).props.elementAt(0));
          }
          emit(usersList);
        } catch (e) {
          emit([e.toString()]);
        }
      }
    });
  }
}
