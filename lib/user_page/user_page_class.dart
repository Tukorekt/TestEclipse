import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wind/generated/l10n.dart';
import 'package:wind/main.dart';
import 'package:wind/user_page/user_page_bloc.dart';
import '../user_info_from_json.dart';

class SecondPage extends StatelessWidget {
  final SecondPageBloc _secondPageBloc =
    SecondPageBloc(const UsersInfo('', '', '', '', '', {}, '', {}, {}));
  final String name;
  final double fontSize = 21;

  SecondPage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    _secondPageBloc.add(SecondPageBlocEvent(name));
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
              BlocBuilder<SecondPageBloc, UsersInfo>(
                  bloc: _secondPageBloc,
                  builder: (BuildContext context, state) {
                    return ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          listTile(S.current.name + state.nameInfo, _size),
                          listTile(S.current.email + state.mail, _size),
                          listTile(S.current.phone + state.phone, _size),
                          listTile(S.current.web_site + state.webSite, _size),
                          listMapTile(context, state.work, _size, S.current.job,
                              false, 1),
                          listTile(S.current.address + state.address, _size),
                          listMapTile(context, state.posts, _size, S.current.posts,
                              true, .95),
                          listMapTile(context, state.albums, _size, S.current.albums,
                              true, .95)
                        ]
                    );
                  }
              )
            ]
        ),
      )
    );
  }

  Widget listTile(String string, Size size) {
    return Container(
      padding: EdgeInsets.only(
        left: size.height * .01,
        top: size.height * .01,
        right: size.height * .01
      ),
      child: Card(
        child: Text(
          string,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fontSize)
        )
      )
    );
  }

  Widget listMapTile(BuildContext context, Map map, Size size, String title,
      bool check, double opacity) {
    return Container(
      padding: EdgeInsets.only(
        left: size.height * .01,
        top: size.height * .01,
        right: size.height * .01
      ),
      child: Card(
        color: Colors.white.withOpacity(opacity),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (title != S.current.job)
                  Text(
                    S.current.more,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0),
                        fontSize: fontSize
                    )
                  ),
                const Expanded(
                  child: SizedBox()
                ),
                Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: fontSize+2
                    )
                ),
                const Expanded(
                  child: SizedBox()
                ),
                if (title != S.current.job)
                  GestureDetector(
                    onTap: () {
                      setUserMap(map);
                      if (title == S.current.posts) {
                        Navigator.pushNamed(context, "/allPostsPage");
                      }
                      if (title == S.current.albums) {
                        Navigator.pushNamed(context, "/allAlbumsPage");
                      }
                    },
                    child: Text(
                      S.current.more,
                      style: TextStyle(color: Colors.blue, fontSize: fontSize)
                    )
                  )
              ]
            ),
            SizedBox(
              height: size.height * .01
            ),
            for (var mapN in map.entries.take(3))
              if (mapN.key == "catchPhrase")
                SizedBox(
                  width: double.infinity,
                  child: Text(
                      "\"" + mapN.value.toString() + "\"",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: fontSize
                      )
                  )
                )
              else if (check)
                GestureDetector(
                  onTap: () {
                    setElementName(mapN.key.toString());
                    if (title == S.current.posts) {
                      Navigator.pushNamed(context, "/postPage");
                    }
                    if(title == S.current.albums){
                      Navigator.pushNamed(context, "/albumPage");
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: size.height * .01),
                    width: double.infinity,
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * .02
                          ),
                          Text(
                            mapN.key.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: fontSize+1
                            )
                          ),
                          SizedBox(
                            height: size.height * .01
                          ),
                          if (title == S.current.albums)
                            Image.network(
                              mapN.value.toString(),
                              height: size.height / 3
                            )
                          else
                            Text(
                              mapN.value.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: fontSize)
                            ),
                          SizedBox(
                            height: size.height * .02
                          )
                        ]
                      )
                    )
                  )
                )
              else
                SizedBox(
                    width: double.infinity,
                    child: Text(
                        mapN.value.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: fontSize)
                    )
                )
          ]
        )
      )
    );
  }
}
