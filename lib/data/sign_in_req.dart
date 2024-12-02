class SignInReq {
  String id;
  String password;

  SignInReq(this.id, this.password);

  Map<String, dynamic> toJson() => {
    "id": id,
    "password": password,
  };
}
