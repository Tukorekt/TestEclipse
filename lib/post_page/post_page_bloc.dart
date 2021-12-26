import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../user_posts_from_json.dart';

abstract class PostPageBlocExt {
  const PostPageBlocExt();
}

class PostPageBlocEvent extends PostPageBlocExt {
  final String postName;
  PostPageBlocEvent(this.postName);
}

class PostPageBloc extends Bloc<PostPageBlocExt, Posts> {
  PostPageBloc(Posts initialState) : super(initialState) {
    on<PostPageBlocEvent>((event, emit) async {
      if (await Hive.boxExists('PostPageCache')){
        await Hive.openBox('PostPageCache');
        if(Hive.box('PostPageCache').keys.contains(event.postName)){
          var box = Hive.box('PostPageCache');
          Posts post = Posts.fromJson(box.get(event.postName), event.postName);
          emit(post);
        } else{
          Posts post = await getEthData(event);
          emit(post);
        }
      } else {
        await Hive.openBox('PostPageCache');
        Posts post = await getEthData(event);
        emit(post);
      }
    });
  }
  Future<Posts> getEthData(PostPageBlocEvent event) async{
    var box = Hive.box('PostPageCache');
    try {
      String _url =
          "https://my-json-server.typicode.com/Tukorekt/TestEclipse/posts?q=${event.postName}";
      var _response =
          await http.get(Uri.parse(_url));
      var _respMap = jsonDecode(_response.body);
      Posts _post = Posts.fromJson(_respMap[0], event.postName);
      box.put(event.postName, _respMap[0]);
      return _post;
    } catch (e) {
      return e.toString() as Posts;
    }
  }
}
