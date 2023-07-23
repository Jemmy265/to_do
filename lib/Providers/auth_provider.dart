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
}