import 'package:http/http.dart';
import 'package:slost_only1_admin/model/dolbom_review.dart';
import 'package:slost_only1_admin/repository/review_repository.dart';
import 'package:slost_only1_admin/support/http_response_handler.dart';
import 'package:slost_only1_admin/support/server_response.dart';
import 'package:slost_only1_admin/support/server_uri.dart';

final class ReviewRepositoryImpl
    with ServerUri, HttpResponseHandler
    implements ReviewRepository {
  ReviewRepositoryImpl(this.interceptedClient);

  final Client interceptedClient;

  @override
  Future<PagedData<DolbomReview>> fetchReportedList(int page) async {
    Uri uri = getUri("/dolbom-review/report",
        queryParameters: {"page": page.toString()});

    Response response = await interceptedClient.get(uri);

    return getPagedData(response, (p) => DolbomReview.fromJson(p)).data;
  }
}
