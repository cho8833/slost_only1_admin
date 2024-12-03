import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slost_only1_admin/provider/auth_provider.dart';
import 'package:slost_only1_admin/provider/review_provider.dart';
import 'package:slost_only1_admin/provider/teacher_provider.dart';
import 'package:slost_only1_admin/provider/token_provider.dart';
import 'package:slost_only1_admin/repository/impl/secure_storage_impl.dart';
import 'package:slost_only1_admin/repository/secure_storage.dart';
import 'package:slost_only1_admin/screen/common/base_screen.dart';
import 'package:slost_only1_admin/screen/login_screen.dart';
import 'package:slost_only1_admin/screen/main_screen.dart';
import 'package:slost_only1_admin/screen/manage_review_screen.dart';
import 'package:slost_only1_admin/screen/manage_teacher_screen.dart';
import 'package:slost_only1_admin/screen/teacher_details_screen.dart';
import 'package:slost_only1_admin/support/repository_container.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  final SecureStorage secureStorage =
  SecureStorageImpl(await SharedPreferences.getInstance());

  // token provider
  TokenProvider tokenProvider = TokenProvider();
  tokenProvider.secureStorage = secureStorage;

  // repository container
  RepositoryContainer rc = RepositoryContainer();
  rc.initialize(secureStorage);

  // auth provider
  AuthProvider authProvider = AuthProvider();
  authProvider.init(rc.authRepository);

  await authProvider.checkSignIn();

  GlobalKey<NavigatorState> rootNavKey = GlobalKey();
  GlobalKey<NavigatorState> shellNavKey = GlobalKey();
  List<GoRoute> routes = [];

  routes.add(GoRoute(
      path: "/",
      parentNavigatorKey: rootNavKey,
      builder: (context, state) => const LoginScreen(),
      redirect: (context, state) {
        String path = state.uri.toString();
        // 로그인 되어 있으면
        // /로 접근 시 main 페이지로 이동
        // /{path} 로 접근 시 그대로
        if (authProvider.isLoggedIn.value) {
          if (path == "/") {
            return "/main";
          } else {
            return null;
          }
        }
        // 로그인 되어 있지 않으면 로그인 화면으로 redirect
        else {
          if (path == "/") {
            return null;
          } else {
            return "/";
          }
        }
      },
      routes: [
        ShellRoute(
            pageBuilder: (context, state, child) {
              return NoTransitionPage(child: BaseScreen(child: child));
            },
            routes: [
              GoRoute(
                  path: "main",
                  builder: (context, state) => const MainScreen()),
              GoRoute(
                  path: "teacher",
                  builder: (context, state) => const ManageTeacherScreen()),
              GoRoute(path: "teacher/:id",
                  builder: (context, state) =>
                      TeacherDetailsScreen(
                          id: int.parse(state.pathParameters['id']!))),
              GoRoute(
                  path: "review",
                  builder: (context, state) => const ManageReviewScreen())
            ],
            navigatorKey: shellNavKey)
      ]));

  final GoRouter router = GoRouter(
      routes: routes,
      navigatorKey: rootNavKey,
      errorBuilder: (context, state) =>
      const Scaffold(
        body: Center(child: Text("허가된 사용자만 이용 가능합니다")),
      ));

  runApp(Main(router: router));
}

class Main extends StatelessWidget {
  const Main({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    RepositoryContainer rc = RepositoryContainer();
    return MultiProvider(
        providers: [
          Provider(create: (context) => ReviewProvider(rc.reviewRepository)),
          Provider(create: (context) => TeacherProvider(rc.teacherRepository))
        ],
        builder: (context, _) {
          return MaterialApp.router(
            routerConfig: router,
          );
        }
    );
  }
}
