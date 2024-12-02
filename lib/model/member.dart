import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  int id;
  String sendbirdAccessToken;


  Member(this.id, this.sendbirdAccessToken);

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  String getSendbirdId() {
    return "ADMIN$id";
  }
}