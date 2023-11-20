import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Database/Model/Task.dart';
import 'package:to_do/Database/Model/user.dart' as MyUser;
import 'package:to_do/Database/my_database.dart';

class AuthProvider extends ChangeNotifier {
  MyUser.User? currentUser;

  void updateUser(MyUser.User loggedInUser) {
    currentUser = loggedInUser;
    notifyListeners();
  }

  void EditTask(Task task) {
    MyDatabase.updateTask(currentUser!.id!, task).then((value) {
      print("task edited");
      notifyListeners();
    });
  }

  bool isUserLoggedInBefore() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> autoLogin() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return;
    currentUser = await MyDatabase.readUser(firebaseUser.uid);
    return;
  }

  void LogOut() {
    FirebaseAuth.instance.signOut();
    currentUser = null;
  }
}