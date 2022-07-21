// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:todolist/pages/add.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:todolist/pages/update_todolist.dart';

class TodoList extends StatefulWidget {
  // const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List todolistitem = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("All TodoList"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  getTodoList();
                });
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: todolistcreate(),
    );
  }

  Widget todolistcreate() {
    return ListView.builder(
        itemCount: todolistitem.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("${todolistitem[index]['title']}"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdatePage(
                            todolistitem[index]['id'],
                            todolistitem[index]['title'],
                            todolistitem[index]['detail']))).then((value) {
                  setState(() {
                    getTodoList();
                  });
                });
              },
            ),
          );
        });
  }

  Future<void> getTodoList() async {
    List alltodo = [];
    var url = Uri.http("192.168.1.35:8000", "/api/all-todolist/");
    var respone = await http.get(url);
    // var result = json.decode(respone.body);
    var result = utf8.decode(respone.bodyBytes);
    setState(() {
      todolistitem = jsonDecode(result);
    });
  }
}
