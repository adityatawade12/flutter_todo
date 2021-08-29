import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:intl/intl.dart';
// import 'package:uuid/uuid.dart';

class TaskList extends StatelessWidget {
  // final uuid = Uuid();
  final List<Task> tasks = [
    Task(taskName: "Clean Shelf", id: "1", date: DateTime.now()),
    Task(taskName: "Buy Table", id: "2", date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.3,
                ),
                Text(
                  "Add a new Task!",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
                Container(
                  height: constraints.maxHeight * 0.3,
                  padding: EdgeInsets.only(left: 50),
                  child: Image.asset("assets/images/note.png"),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                child: ListTile(
                  // leading: CircleAvatar(
                  //   backgroundColor: Theme.of(context).accentColor,
                  //   radius: 45,
                  //   child: Padding(
                  //     padding: EdgeInsets.all(20),
                  //     child: FittedBox(
                  //       child: Text(
                  //         "12.30 AM",
                  //         style: TextStyle(
                  //             color: Colors.brown,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 30),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  leading: Container(
                    width: 90,
                    height: 80,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        "12.30 AM",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tasks[index].taskName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                  subtitle: Text(DateFormat.yMMMd().format(tasks[index].date)),
                ),
              );
            },
            itemCount: tasks.length,
          );
  }
}
