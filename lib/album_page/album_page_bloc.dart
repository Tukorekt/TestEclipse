import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../users_albums_from_json.dart';

abstract class AlbumPageBlocExt {
  const AlbumPageBlocExt();
}

class AlbumPageBlocEvent extends AlbumPageBlocExt {
  String albumName, name;
  AlbumPageBlocEvent(this.albumName, this.name);
}

class AlbumPageBloc extends Bloc<AlbumPageBlocExt, Map> {
  AlbumPageBloc(Map initialState) : super(initialState) {
    on<AlbumPageBlocEvent>((event, emit) async {
      if(await Hive.boxExists('AlumPageCache')){
        await Hive.openBox('AlumPageCache');
        if(Hive.box('AlumPageCache').keys.contains(event.albumName)){
          var box = Hive.box('AlumPageCache');
          emit(box.get(event.albumName));
        } else{
          Map map = await getEthData(event);
          emit(map);
        }
      } else {
        await Hive.openBox('AlumPageCache');
        Map map = await getEthData(event);
        emit(map);
      }
    });
  }
  Future<Map> getEthData(AlbumPageBlocEvent event)async{
    var box = Hive.box('AlumPageCache');
    try {
      String url =
          "https://my-json-server.typicode.com/Tukorekt/TestEclipse/albums?q=${event.name}";
      var response = await http.get(Uri.parse(url));
      var respMap = jsonDecode(response.body);
      Albums album = Albums.fromJson(respMap[0], event.albumName);
      await box.put(event.albumName, respMap[0]['userAlbs'][event.albumName]);
      return album.albs;
    } catch (e) {
      return {e.toString():e.toString()};
    }
  }
}
