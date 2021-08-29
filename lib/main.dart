import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/newTaskModal.dart';
import 'package:todo_app/widgets/taskList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Task> tasks = [
    // Task(
    //     taskName: "Clean Shelf asd asd asds ad asdsd asdsa asdsa asds ",
    //     id: "1",
    //     date: DateTime.now(),
    //     time: TimeOfDay.now()),
    // Task(
    //     taskName: "Buy Table",
    //     id: "2",
    //     date: DateTime.now(),
    //     time: TimeOfDay.now()),
  ];

  void _addTask(task, date, time) {
    var newtask = Task(
        taskName: task, id: DateTime.now().toString(), date: date, time: time);
    setState(() {
      tasks.add(newtask);
      Navigator.of(context).pop();
    });
  }

  void _deleteTask(id) {
    setState(() {
      tasks.removeWhere((task) => task.id == id);
    });
  }

  void _showModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (builder) {
          return GestureDetector(
            child: TaskModal(_addTask),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TaskList(tasks, _deleteTask),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showModal(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
