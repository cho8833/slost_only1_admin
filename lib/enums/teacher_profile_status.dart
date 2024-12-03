enum TeacherProfileStatus {
  pending("PENDING", "대기중"),
  approved("APPROVED", "승인됨"),
  rejected("REJECTED", "거절됨");

  final String json;

  final String title;

  const TeacherProfileStatus(this.json, this.title);

  @override
  String toString() {
    return title;
  }

  String toJson() {
    return json;
  }

  factory TeacherProfileStatus.fromJson(String json) {
    return TeacherProfileStatus.values.firstWhere((element) => element.toJson() == json);
  }
}