
import 'package:http_interceptor/http_interceptor.dart';
import 'package:slost_only1_admin/repository/auth_repository.dart';
import 'package:slost_only1_admin/repository/impl/auth_repository_impl.dart';
import 'package:slost_only1_admin/repository/impl/review_repository_impl.dart';
import 'package:slost_only1_admin/repository/impl/teacher_repository_impl.dart';
import 'package:slost_only1_admin/repository/review_repository.dart';
import 'package:slost_only1_admin/repository/secure_storage.dart';
import 'package:slost_only1_admin/repository/teacher_repository.dart';
import 'package:slost_only1_admin/support/http_request_interceptor.dart';

class RepositoryContainer {
  late final AuthRepository authRepository;
  late final TeacherRepository teacherRepository;
  late final ReviewRepository reviewRepository;


  RepositoryContainer._internal();

  void initialize(SecureStorage secureStorage) {
    TokenInterceptor interceptor = TokenInterceptor(secureStorage);
    ContentTypeInterceptor contentTypeInterceptor = ContentTypeInterceptor();
    Client client = InterceptedClient.build(
        interceptors: [contentTypeInterceptor], client: Client());
    Client interceptedClient = InterceptedClient.build(
        interceptors: [contentTypeInterceptor, interceptor], client: Client());
    authRepository = AuthRepositoryImpl(client, interceptedClient);
    teacherRepository = TeacherRepositoryImpl(interceptedClient);
    reviewRepository = ReviewRepositoryImpl(interceptedClient);
    interceptor.authRepository = authRepository;
  }

  static final RepositoryContainer _instance = RepositoryContainer._internal();

  factory RepositoryContainer() {
    return _instance;
  }
}
