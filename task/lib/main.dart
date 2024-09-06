import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 96, 242, 255)),
        useMaterial3: true,
      ),
      home: const TodaApp(),
    );
  }
}

class TodaApp extends StatefulWidget {
  const TodaApp({
    super.key,
  });

  @override
  State<TodaApp> createState() => _TodaAppState();
}

class _TodaAppState extends State<TodaApp> {
  late TextEditingController _titleController;
  late TextEditingController _detailController;
  final List<Map<String, String>> _myList = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _detailController = TextEditingController();
  }

  void addTodoHandle(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 190, 241, 255),
            title: const Text(
              "Add new task",
              style: TextStyle(color: Colors.blue),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  style: TextStyle(color: Color.fromARGB(255, 93, 119, 191)),
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Title",
                    labelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  style: TextStyle(color: Color.fromARGB(255, 191, 100, 93)),
                  controller: _detailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Detail",
                    labelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _myList.add({
                        'title': _titleController.text,
                        'detail': _detailController.text,
                      });
                    });
                    _titleController.text = "";
                    _detailController.text = "";
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo",
          style: TextStyle(color: Color.fromARGB(255, 0, 15, 88)),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _myList.isEmpty
          ? const Center(
              child: Text(
                'No tasks yet!',
                style: TextStyle(color: Color.fromARGB(255, 9, 90, 90)),
              ),
            )
          : ListView.builder(
              itemCount: _myList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _myList[index]['title']!,
                    style: TextStyle(
                        color: Color.fromARGB(255, 93, 119, 191), fontSize: 30),
                  ),
                  subtitle: Text(
                    _myList[index]['detail']!,
                    style: TextStyle(color: Color.fromARGB(255, 191, 100, 93)),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodoHandle(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
