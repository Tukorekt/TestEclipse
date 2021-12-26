import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wind/generated/l10n.dart';
import 'package:wind/post_page/post_page_bloc.dart';

import '../user_posts_from_json.dart';

class PostPage extends StatelessWidget {
  final PostPageBloc _postPageBloc = PostPageBloc(const Posts('', [], ''));
  final String postName;

  PostPage({Key? key, required this.postName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _postPageBloc.add(PostPageBlocEvent(postName));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          postName,
          style: const TextStyle(color: Colors.yellowAccent),
          maxLines: 1,
        )
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(.1),
            ),
            BlocBuilder<PostPageBloc, Posts>(
              bloc: _postPageBloc,
              builder: (BuildContext context, state) {
                if (state != null) {
                  return ListView(
                    children: [
                      Card(
                        child: Column(
                          children: [
                            Text(
                                postName,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            Text(
                                state.info,
                                style: const TextStyle(fontSize: 20)
                            )
                          ]
                        )
                      ),
                      Card(
                        child: Column(
                          children: [
                            Text(S.current.comments,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            for (var comment in state.comments)
                              Text(
                                  comment.values.elementAt(1) +
                                      " (${comment.values.elementAt(2)}):" +
                                      "\n" +
                                      comment.values.elementAt(3)+"\n",
                                  textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 20),
                              )
                          ]
                        )
                      ),
                      ElevatedButton(
                        onPressed: () =>
                          Navigator.pushNamed(context, '/commentSendPage'),
                        child: Text(
                          S.current.send_comment,
                          style: const TextStyle(fontSize: 20),
                        )
                      )
                    ]
                  );
                } else {
                  return Text(S.current.getting_data);
                }
              }
            )
          ]
        )
      )
    );
  }
}
