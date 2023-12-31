import 'package:flutter/material.dart';
import 'package:to_do/My_Date_Utils.dart';
import 'package:to_do/ui/Components/custom_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add New Task",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            CustomFormField(
              label: "Task Title",
              controller: titleController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return "Please Enter Task Title";
                }
              },
            ),
            CustomFormField(
              label: "Task Description",
              controller: descriptionController,
              lines: 5,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return "Please Enter Task description";
                }
              },
            ),
            SizedBox(
              height: 12,
            ),
            Text("Task Date"),
            InkWell(
              onTap: (){
                showTaskDatePicker();
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black54)
                  )
                ),
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "${MyDateUtils.FormatTaskDate(selectedDate)}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addTask();
              },
              child: Text(
                "Add Task",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(16)),
            )
          ],
        ),
      ),
    );
  }

  void addTask() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
  }
  var selectedDate = DateTime.now();
  void showTaskDatePicker() async {
    var date = await showDatePicker(context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if(date == null)return;
    selectedDate = date;
    setState(() {});
  }
}
