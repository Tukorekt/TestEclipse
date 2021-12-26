import 'package:equatable/equatable.dart';

class Albums extends Equatable {
  final String title;
  final Map albs;

  const Albums(this.title, this.albs);

  Albums.fromJson(Map<dynamic, dynamic> json, String find)
      : title = json['userName'],
        albs = json['userAlbs'][find];

  @override
  List<Object?> get props => [title, albs];
}
