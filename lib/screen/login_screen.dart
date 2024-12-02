import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:slost_only1_admin/data/sign_in_req.dart';
import 'package:slost_only1_admin/main.dart';
import 'package:slost_only1_admin/provider/auth_provider.dart';
import 'package:slost_only1_admin/widget/button_base.dart';
import 'package:slost_only1_admin/widget/text_field_template.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String id = "";
  String pw = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 500,
              child: Column(
                children: [
                  const Text("슬로스트온니원"),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFieldTemplate(
                    hint: "ID",
                    onChange: (text) {
                      id = text;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFieldTemplate(
                    hint: "PW",
                    onChange: (text) {
                      pw = text;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ButtonTemplate(
                      title: "로그인",
                      onTap: () {
                        SignInReq req = SignInReq(id, pw);
                        AuthProvider().signIn(req).then((_) {
                          context.go("/main");
                        }).catchError((e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e.toString())));
                        });
                      },
                      isEnable: true)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
