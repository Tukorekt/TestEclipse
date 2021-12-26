import 'package:flutter/material.dart';
import 'package:wind/generated/l10n.dart';
import 'package:wind/main.dart';

class AllAlbumsPage extends StatelessWidget {
  final Map map;
  const AllAlbumsPage({Key? key, required this.map}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          S.current.albums,
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
                      listMapTile(context, post, size)
                  ]
              )
            ]
        ),
      )
    );
  }

  Widget listMapTile(BuildContext context, MapEntry list, Size size) {
    return Container(
        padding: EdgeInsets.only(
            top: size.height * .01,
            left: size.height * .01,
            right: size.height * .01),
        child: GestureDetector(
            onTap: () {
              print(list.key);
              setElementName(list.key.toString());
              Navigator.pushNamed(context, "/albumPage");
            },
            child: Card(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .01,
                  ),
                  Text(
                    list.key.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  Image.network(
                    list.value.toString(),
                    height: size.height / 2,
                    width: size.width * .9,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                ],
              ),
            )));
  }
}
