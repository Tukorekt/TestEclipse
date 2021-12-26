import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wind/generated/l10n.dart';
import 'package:wind/main.dart';
import 'first_page_bloc.dart';

class First extends StatelessWidget {
  final FirstPageBloc _firstPageBloc = FirstPageBloc([]);
  First({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _firstPageBloc.add(const FirstPageBlocEvent());
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            S.current.main_app_bar_title,
            style: const TextStyle(color: Colors.yellowAccent)
          )
        ),
        body: SafeArea(
          child: Stack(
              children: [
                Container(
                    color: Colors.black.withOpacity(.05)
                ),
                BlocBuilder<FirstPageBloc, List>(
                    bloc: _firstPageBloc,
                    builder: (BuildContext context, list) {
                      if (list.isNotEmpty) {
                        return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: list.length,
                            itemBuilder: (_, count) {
                              return GestureDetector(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: _size.height * .01,
                                          right: _size.height * .01,
                                          top: _size.height * .01
                                      ),
                                      child: Card(
                                          shadowColor: Colors.black,
                                          child: Column(
                                              children: [
                                                SizedBox(
                                                    height: _size.height * .01
                                                ),
                                                Text(
                                                    S.current.nick_name +
                                                        list.elementAt(count).name,
                                                    style: const TextStyle(fontSize: 19)
                                                ),
                                                SizedBox(
                                                    height: _size.height * .01
                                                ),
                                                Text(
                                                    S.current.name +
                                                        list.elementAt(count).nameInfo,
                                                    style: const TextStyle(fontSize: 19)
                                                ),
                                                SizedBox(
                                                    height: _size.height * .01
                                                )
                                              ]
                                          )
                                      )
                                  ),
                                  onTap: () {
                                    setUserName(list.elementAt(count).name);
                                    Navigator.pushNamed(context, "/userPage");
                                  }
                              );
                            }
                        );
                      } else {
                        return Center(
                            child: Text(S.current.getting_data)
                        );
                      }
                    }
                )
              ]
          ),
        )
    );
  }
}
