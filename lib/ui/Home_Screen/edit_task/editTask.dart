import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Database/Model/Task.dart';
import 'package:to_do/My_Date_Utils.dart';
import 'package:to_do/Providers/auth_provider.dart';
import 'package:to_do/ui/Components/custom_form_field.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = "editTask";

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  DateTime today = DateTime.now();

  TextEditingController? titleController;

  TextEditingController? descriptionController;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Task task = ModalRoute.of(context)?.settings.arguments as Task;
    if(titleController == null || descriptionController == null) {
      titleController = TextEditingController(text: task.title);
      descriptionController = TextEditingController(text: task.description);
    }
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              AppBar(
                title: Text("To Do List"),
                centerTitle: false,
                backgroundColor: Theme.of(context).primaryColor,
                flexibleSpace: SizedBox(
                  height: height * 0.25,
                ),
              )
            ],
          ),
          Positioned(
            top: height * 0.15,
            child: Container(
              padding: EdgeInsets.all(20),
              width: width * 0.8,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Edit Task",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    CustomFormField(
                      label: "Task title",
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "Please Enter Task Title";
                        }
                      },
                      controller: titleController!,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CustomFormField(
                      label: "Task description",
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "Please Enter Task description";
                        }
                      },
                      controller: descriptionController!,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Select time",
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    GestureDetector(
                        onTap: () {
                          showTaskDatePicker(task);
                          setState(() {});
                        },
                        child: Text(
                          MyDateUtils.FormatTaskDate(task.dateTime!),
                        )),
                    SizedBox(
                      height: height * 0.10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          task.title = titleController?.text;
                          task.description = descriptionController?.text;
                          authProvider.EditTask(task);
                        }
                        setState(() {});
                      },
                      child: Text("Save Changes"),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * 0.7, height * 0.06),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController?.dispose();
    descriptionController?.dispose();
    super.dispose();
  }

  void showTaskDatePicker(Task task) {
    showDatePicker(
      context: context,
      initialDate: task.dateTime!,
      firstDate: DateTime.now(),
      lastDate: task.dateTime!.add(Duration(days: 365)),
    ).then((value) {
      if(value!= null) {
        task.dateTime = value;
      }
    }
    );
    setState(() {});
  }
}
