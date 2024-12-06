import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1_admin/enums/review_report_reason.dart';

part 'dolbom_review.g.dart';

@JsonSerializable()
class DolbomReview {
  int id;
  String content;
  int star;
  int dolbomId;
  String? reportContent;
  ReviewReportReason reportReason;


  DolbomReview(this.id, this.content, this.star, this.dolbomId,
      this.reportContent, this.reportReason);

  Map<String, dynamic> toJson() => _$DolbomReviewToJson(this);

  factory DolbomReview.fromJson(Map<String, dynamic> json) => _$DolbomReviewFromJson(json);
}