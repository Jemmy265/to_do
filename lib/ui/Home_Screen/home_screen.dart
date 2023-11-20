import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Providers/auth_provider.dart';
import 'package:to_do/ui/Home_Screen/settings/Setting_tab.dart';
import 'package:to_do/ui/Home_Screen/todos_List/todos_list_tab.dart';
import 'package:to_do/ui/login/Login_Screen.dart';

import 'add_task_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do App"),
        actions: [
          IconButton(
            onPressed: () {
              logOut();
              Navigator.pushReplacementNamed(context, LoginScreen.routename);
            },
            icon: Icon(Icons.logout),
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(
          side: BorderSide(color: Colors.white, width: 4),
        ),
        onPressed: (){
          showAddTaskSheet();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index){
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list, size: 32,), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings, size: 32), label: "")
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  void showAddTaskSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildcontext) {
          return AddTaskBottomSheet();
        });
  }

  void logOut() {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.LogOut();
  }

  var tabs = [
    TodosListTab(),
    SettingsTab(),
  ];
}
