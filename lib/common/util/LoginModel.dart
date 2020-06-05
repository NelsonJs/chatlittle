import 'package:flutter/foundation.dart';
import 'package:littelchat/bean/AccountBea.dart';

class LoginModel extends ChangeNotifier {
  AccountBean accountBean;

  void setAccountBean(AccountBean bean) {
    this.accountBean = bean;
    notifyListeners();
  }
}