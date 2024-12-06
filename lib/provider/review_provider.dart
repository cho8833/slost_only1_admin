import 'package:flutter/cupertino.dart';
import 'package:slost_only1_admin/model/dolbom_review.dart';
import 'package:slost_only1_admin/repository/review_repository.dart';
import 'package:slost_only1_admin/support/server_response.dart';
import 'package:status_builder/status_builder.dart';

class ReviewProvider {
  ReviewProvider(this.repository);

  final ReviewRepository repository;

  final ValueNotifier<Status> deleteStatus = ValueNotifier(Status.idle);

  Future<PagedData<DolbomReview>> reportedList(int page) {
    return repository.fetchReportedList(page);
  }

  Future<void> delete(int id) async {
    deleteStatus.value = Status.loading;
    await repository.delete(id).then((_) {
      deleteStatus.value = Status.idle;
    }).catchError((e) {
      deleteStatus.value = Status.idle;
      throw e;
    });
  }
}