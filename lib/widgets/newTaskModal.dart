import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskModal extends StatefulWidget {
  // TaskModal({Key? key}) : super(key: key);
  final Function newTask;
  TaskModal(this.newTask);

  @override
  _TaskModalState createState() => _TaskModalState();
}

class _TaskModalState extends State<TaskModal> {
  final taskController = TextEditingController();
  var _selectedDate = DateTime(1990);
  var _selectedTime;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      } else {
        setState(() {
          _selectedDate = date;
        });
      }
    });
  }

  void _presentTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((time) {
      if (time == null) {
        return;
      } else {
        setState(() {
          _selectedTime = time;
        });
      }
    });
  }

  void saveTask() {
    if (taskController.text == "" ||
        _selectedDate == DateTime(1990) ||
        _selectedTime == null) return;
    widget.newTask(taskController.text, _selectedDate, _selectedTime);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.vertical * 0.5),
      child: Card(
        child: Container(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "Task"),
                  controller: taskController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          _selectedDate == DateTime(1990)
                              ? "No Date Chosen"
                              : DateFormat.yMMMd().format(_selectedDate),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: _presentDatePicker,
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange)),
                          child: Text(
                            "Choose Date",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          _selectedTime == null
                              ? "No Time Chosen"
                              : localizations.formatTimeOfDay(_selectedTime),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: _presentTimePicker,
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange)),
                          child: Text(
                            "Choose Time",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: saveTask,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.orange)),
                    child: Text(
                      "Save Task",
                      style: TextStyle(color: Colors.white),
                    )),
                // if (MediaQuery.of(context).viewInsets.bottom > 0)
                // SizedBox(
                //   height: 400,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
