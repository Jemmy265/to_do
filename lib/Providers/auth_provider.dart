import 'package:flutter/material.dart';
import 'package:to_do/Database/Model/user.dart';

class AuthProvider extends ChangeNotifier {
  User? currentUser;
  void updateUser(User loggedInUser) {
    currentUser = loggedInUser;
    notifyListeners();
  }
}