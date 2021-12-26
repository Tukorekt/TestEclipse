import 'package:equatable/equatable.dart';

class UsersList extends Equatable {
  final String name;
  final String nameInfo;

  const UsersList(this.name, this.nameInfo);

  UsersList.fromJson(Map<dynamic, dynamic> json)
      : name = json['userName'],
        nameInfo = json['name'];

  UsersList.fromCache(Map<dynamic, dynamic> json)
      : name = json.keys.first,
        nameInfo = json.values.first;

  @override
  List<Object?> get props => [{name:nameInfo}];
}
