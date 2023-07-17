import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do/Database/Model/Task.dart';
import 'package:to_do/Database/my_database.dart';
import 'package:to_do/My_Date_Utils.dart';
import 'package:to_do/Providers/auth_provider.dart';
import 'package:to_do/ui/Home_Screen/todos_List/task_item.dart';

class TodosListTab extends StatefulWidget {
  @override
  State<TodosListTab> createState() => _TodosListTabState();
}

class _TodosListTabState extends State<TodosListTab> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);

    return Container(
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().subtract(Duration(days: 365)),
            lastDay: DateTime.now().add(Duration(days: 365)),
            focusedDay: focusedDate,
            calendarFormat: CalendarFormat.week,
            selectedDayPredicate: (day) {
              return isSameDay(selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDate = selectedDay;
                this.focusedDate = focusedDay;
              });
            },
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot<Task>>(
            stream: MyDatabase.getTasksRealTimeUpdates(
                authProvider.currentUser?.id ?? "",
                MyDateUtils.dateonly(selectedDate).millisecondsSinceEpoch),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var tasksList = snapshot.data?.docs
                  .map((docSnapShot) => docSnapShot.data())
                  .toList();
              if (tasksList?.isEmpty == true) {
                return Center(
                  child: Text("You Don't have Tasks"),
                );
              }
              return ListView.builder(
                itemBuilder: (_, index) {
                  return TaskItem(tasksList![index]);
                },
                itemCount: tasksList?.length ?? 0,
              );
            },
          ))
        ],
      ),
    );
  }
}
