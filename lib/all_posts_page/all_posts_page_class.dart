import 'package:flutter/material.dart';
import 'package:wind/generated/l10n.dart';
import 'package:wind/main.dart';

class AllPostsPage extends StatelessWidget {
  final Map map;
  const AllPostsPage({Key? key, required this.map}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          S.current.posts,
          style: const TextStyle(color: Colors.yellowAccent)
        )
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                color: Colors.black.withOpacity(.05)
            ),
            ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  for (var post in map.entries)
                    listMapTile(context, post, _size)
                ]
            )
          ]
        )
      )
    );
  }

  Widget listMapTile(BuildContext context, MapEntry list, Size size) {
    return Container(
        padding: EdgeInsets.only(
            top: size.height * .01,
            left: size.height * .01,
            right: size.height * .01
        ),
        child: GestureDetector(
            onTap: () {
              setElementName(list.key.toString());
              Navigator.pushNamed(context, "/postPage");
            },
            child: Card(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .01
                  ),
                  Text(
                    list.key.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 20
                    )
                  ),
                  SizedBox(
                    height: size.height * .01
                  ),
                  Text(list.value.toString(),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 19)
                  ),
                  SizedBox(
                    height: size.height * .01
                  )
                ]
              )
            )
        )
    );
  }
}
