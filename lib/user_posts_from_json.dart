import 'package:equatable/equatable.dart';

class Posts extends Equatable {
  final String title;
  final String info;
  final List comments;

  const Posts(this.title, this.comments, this.info);

  Posts.fromJson(Map<dynamic, dynamic> json, String find)
      : title = json['userName'],
        info = json['userPosts'][find]['info'],
        comments = json['userPosts'][find]['comments'] as List;

  @override
  List<Object?> get props => [title, comments];
}
