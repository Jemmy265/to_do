import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Database/Model/Task.dart';
import 'package:to_do/Database/my_database.dart';
import 'package:to_do/Dialogs.dart';
import 'package:to_do/Providers/auth_provider.dart';
import 'package:to_do/ui/Home_Screen/edit_task/editTask.dart';

class TaskItem extends StatefulWidget {
  Task task;
  TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return InkWell(
      onTap: () {
        if (!(widget.task.isDone??false)) {
          Navigator.pushNamed(context, EditTaskScreen.routeName,
              arguments: widget.task);
        }
      },
      child: Container(
        margin: EdgeInsets.all(12),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: .25,
            motion: DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (buildContext) {
                  deleteTask();
                },
                icon: Icons.delete,
                backgroundColor: Colors.red,
                label: 'Delete',
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
              )
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: widget.task.isDone ?? false
                        ? Theme.of(context).secondaryHeaderColor
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  width: 8,
                  height: 80,
                ),
                SizedBox(width: 12),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.task.title}",
                      style: TextStyle(
                        fontSize: 18,
                        color: widget.task.isDone ?? false
                            ? Theme.of(context).secondaryHeaderColor
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 18),
                    Text("${widget.task.description}"),
                  ],
                )),
                SizedBox(width: 12),
                widget.task.isDone ?? false
                    ? Text(
                        "Done!",
                        style: Theme.of(context).textTheme.headlineLarge,
                      )
                    : InkWell(
                        onTap: () {
                          widget.task.isDone = true;
                          authProvider.EditTask(widget.task);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset("assets/images/ic_check.png"),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTask() {
    dialogs.showMessage(
      context,
      "This Task will be deleted, Are you Sure?",
      PosActionName: "Yes",
      PosAction: () {
        deleteTaskFromDatabase();
      },
      NegActionName: "Cancel",
    );
  }

  void deleteTaskFromDatabase() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      await MyDatabase.deleteTask(
          authProvider.currentUser?.id ?? "", widget.task.id ?? "");
      Fluttertoast.showToast(
        msg: "Task Deleted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      dialogs.showMessage(context, "Something went wrong" '${e.toString()}');
    }
  }
}
