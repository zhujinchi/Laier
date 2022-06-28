class User {
  User._privateConstructor();

  static final User _instance = User._privateConstructor();

  static User shared() {
    return _instance;
  }

  //user info
  late String id;
  late String userName;
  late String userPhone;

  //
  bool canVibrate = true;

}
