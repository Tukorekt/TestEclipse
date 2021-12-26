import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

abstract class CommentSendPageBlocExt {
  const CommentSendPageBlocExt();
}

class CommentSendPageBlocEvent extends CommentSendPageBlocExt {
  final String searchName;
  final String userName, email, comment;
  const CommentSendPageBlocEvent(this.searchName, this.comment, this.userName,
      this.email);
}

class CommentSendPageBloc extends Bloc<CommentSendPageBlocExt, String> {
  CommentSendPageBloc(String initialState) : super(initialState) {
    on<CommentSendPageBlocEvent>((event, emit) async {
        var _url =
          "https://my-json-server.typicode.com/Tukorekt/TestEclipse/posts";
      var _resp = await http.post(
          Uri.parse(_url),
          headers:{"q" : event.searchName},
          body: {"userName" : event.userName, "email" : event.email, "comment" : event.comment}
          );
        var box = Hive.box('PostPageCache');
        Map map = box.get(event.searchName);
        List listMap = map['userPosts'][event.searchName]['comments'];
        listMap.add(
          {'id':1,'userName':event.userName,'email':event.email, 'comment':event.comment});
        Map newMap = map;
        await box.delete(event.searchName);
        await box.put(event.searchName, newMap);
        emit(_resp.body);
    });
  }
}
