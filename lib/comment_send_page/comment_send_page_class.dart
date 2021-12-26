import 'package:flutter/material.dart';
import 'package:wind/comment_send_page/comment_send_page_bloc.dart';
import 'package:wind/generated/l10n.dart';

class CommentSendPage extends StatelessWidget{
  final String name;
  CommentSendPage({Key? key, required this.name}) : super(key: key);

  final CommentSendPageBloc _commentSendPageBloc = CommentSendPageBloc('');

  @override
  Widget build(BuildContext context) {
    String _name = '', _email = '', _comment = '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          name,
          style: const TextStyle(color: Colors.yellowAccent)
        )
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(.05)
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  child: Text(
                    S.current.send_comment,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
                Card(
                  child: TextField(
                    maxLines: 1,
                    onChanged: (string) => _name = string
                  )
                ),
                Card(
                  child: TextField(
                    onChanged: (string) => _email = string
                  )
                ),
                Card(
                  child: TextField(
                    maxLines: 4,
                    onChanged: (string) => _comment = string
                  )
                ),
                ElevatedButton(
                  onPressed: (){
                    if (_name != '' && _email != '' && _comment != ''){
                      _commentSendPageBloc.add(CommentSendPageBlocEvent(
                          name, _comment, _name, _email));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    S.current.send,
                    style: const TextStyle(fontSize: 20),
                  )
                )
              ]
            )
          ]
        )
      )
    );
  }
}