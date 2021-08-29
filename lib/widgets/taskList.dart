import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:intl/intl.dart';
// import 'package:multi_sort/multi_sort.dart';
// import 'package:uuid/uuid.dart';

class TaskList extends StatelessWidget {
  // final uuid = Uuid();
  // final List<Task> tasks = [
  //   Task(
  //       taskName: "Clean Shelf asd asd asds ad asdsd asdsa asdsa asds ",
  //       id: "1",
  //       date: DateTime.now()),
  //   Task(taskName: "Buy Table", id: "2", date: DateTime.now()),
  // ];
  List<Task> tasks;
  Function deleteTask;
  TaskList(this.tasks, this.deleteTask);
  List<bool> criteria = [true, true]; //Criteria List
  List<String> preferrence = ["date", "time"];
  // List<Task> get sortedTaks {
  //   return tasks.multisort(criteria, preferrence);
  // }
  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
  @override
  Widget build(BuildContext context) {
    tasks.sort((a, b) {
      var comparisonResult = a.date.compareTo(b.date);
      if (comparisonResult != 0) {
        return comparisonResult;
      }

      return toDouble(a.time).compareTo(toDouble((b.time)));
    });
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
        : LayoutBuilder(builder: (ctx, constraints) {
            return ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).accentColor,
                        ),
                        child: Center(
                            child: Text(
                          MaterialLocalizations.of(context)
                              .formatTimeOfDay(tasks[index].time),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.1,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: constraints.maxWidth * 0.4,
                              child: Text(
                                tasks[index].taskName,
                                // overflow: TextOverflow.ellipsis,
                                // textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd().format(tasks[index].date),
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(width: constraints.maxWidth * 0.1),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            deleteTask(tasks[index].id);
                          },
                          padding: EdgeInsets.all(5),
                          icon: Icon(
                            Icons.done,
                            size: 40,
                            color: Colors.green,
                          ))
                    ],
                  ),
                ));
              },
              itemCount: tasks.length,
            );
          });
  }
}
