import 'package:slost_only1_admin/model/dolbom_review.dart';
import 'package:slost_only1_admin/support/server_response.dart';

abstract interface class ReviewRepository {
  Future<PagedData<DolbomReview>> fetchReportedList(int page);

  Future<void> delete(int id);
}