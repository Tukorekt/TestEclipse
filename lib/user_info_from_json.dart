import 'package:equatable/equatable.dart';

class UsersInfo extends Equatable {

  final String name;
  final String nameInfo;
  final String mail;
  final String phone;
  final String webSite;
  final Map work;
  final String address;
  final Map posts;
  final Map albums;

  const UsersInfo(this.name, this.nameInfo, this.mail, this.phone, this.webSite,
      this.work, this.address, this.albums, this.posts);

  UsersInfo.fromJson(Map<dynamic, dynamic> json)
      : name = json['userName'],
        nameInfo = json['name'],
        mail = json['email'],
        phone = json['phone'],
        webSite = json['webSite'],
        work = json['job'],
        address = json['address'],
        posts = json['posts'],
        albums = json['albums'];

  UsersInfo.error(String exc):
        name = exc,
        nameInfo = exc,
        mail = exc,
        phone = exc,
        webSite = exc,
        work = {exc:exc},
        address = exc,
        posts = {exc:exc},
        albums = {exc:exc};

  @override
  List<Object?> get props =>
      [name, nameInfo, mail, phone, webSite, work, address, albums, posts];
}


