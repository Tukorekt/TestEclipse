import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wind/generated/l10n.dart';
import 'album_page_bloc.dart';


class AlbumPage extends StatelessWidget {
  final AlbumPageBloc _albumPageBloc = AlbumPageBloc({});
  final String albumName, name;
  AlbumPage({Key? key, required this.albumName, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _albumPageBloc.add(AlbumPageBlocEvent(albumName,name));
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          albumName,
          style: const TextStyle(color: Colors.yellowAccent)
        )
      ),
      body: SafeArea(
        child: Stack(
            children: [
              Container(color: Colors.black.withOpacity(.05)),
              BlocBuilder<AlbumPageBloc, Map>(
                  bloc: _albumPageBloc,
                  builder: (BuildContext context, state) {
                    Map map = state;
                    if (map != null) {
                      return PageView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.length,
                          itemBuilder: (_, int index) {
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      height: _size.height * .01
                                  ),
                                  Expanded(
                                      child: SizedBox(
                                          width: _size.width,
                                          height: _size.height * .6,
                                          child:PhotoView(
                                            backgroundDecoration: BoxDecoration(color: Colors.white.withOpacity(.05)),
                                            initialScale: PhotoViewComputedScale.contained,
                                            minScale: PhotoViewComputedScale.contained,
                                            maxScale: PhotoViewComputedScale.contained * 1.5,
                                            enableRotation: false,
                                            imageProvider: NetworkImage(map.values.elementAt(index)),
                                          )
                                      )
                                  ),
                                  Card(
                                      child: Text(
                                        map.keys.elementAt(index).toString(),
                                        style: const TextStyle(fontSize: 19),
                                        textAlign: TextAlign.center,
                                      )
                                  ),
                                  SizedBox(
                                      height: _size.height * .05
                                  ),

                                ]
                            );
                          }
                      );
                    } else {
                      return  Text(S.current.getting_data);
                    }
                  }
              )
            ]
        ),
      )
    );
  }
}
