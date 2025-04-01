import 'package:flutter/material.dart';
import 'package:todo_app/task.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController taskController = TextEditingController();
  final List<Task> tasks = [];
  
  void addTask (String title) {
    setState((){
      tasks.add(Task(title: title));
    });
  }

  void removeTask (int index){
    setState((){
      tasks.removeAt(index);
    });
  }

  void toggleTask (int index){
    setState((){
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List'),),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(child: TextField(
                controller: taskController,
                decoration: InputDecoration(hintText: 'Enter a task'),
              ),
              ),
              IconButton(onPressed: () {
                if (taskController.text.isNotEmpty){
                  addTask(taskController.text);
                }
              }, 
              icon: Icon(Icons.add))
            ],
          ),),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(
                    tasks[index].title,
                    style: TextStyle(
                      decoration: tasks[index].isCompleted 
                      ? TextDecoration.lineThrough 
                      : TextDecoration.none
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () => removeTask(index), 
                    icon: Icon(Icons.remove),
                    ),
                    onTap: () => toggleTask(index),
                );
              }
              ),
          ),
        ],
      ),
    );
  }
}
