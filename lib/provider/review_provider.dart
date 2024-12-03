import 'package:slost_only1_admin/model/dolbom_review.dart';
import 'package:slost_only1_admin/repository/review_repository.dart';
import 'package:slost_only1_admin/support/server_response.dart';

class ReviewProvider {
  ReviewProvider(this.repository);

  final ReviewRepository repository;

  Future<PagedData<DolbomReview>> reportedList(int page) {
    return repository.fetchReportedList(page);
  }

}