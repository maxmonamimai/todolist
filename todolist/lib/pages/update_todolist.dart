// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:todolist/pages/todolist.dart';

class UpdatePage extends StatefulWidget {
  final v1, v2, v3;
  const UpdatePage(this.v1, this.v2, this.v3);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  var _v1, _v2, _v3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1;
    _v2 = widget.v2;
    _v3 = widget.v3;

    todo_title.text = _v2;
    todo_detail.text = _v3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
        actions: [
          IconButton(
              onPressed: () {
                deleteTodo();
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // ช่องกรอกข้อมูล Title
            TextField(
              controller: todo_title,
              decoration: InputDecoration(
                  labelText: 'Title', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: todo_detail,
              decoration: InputDecoration(
                  labelText: 'Detail', border: OutlineInputBorder()),
              minLines: 4,
              maxLines: 8,
            ),
            SizedBox(
              height: 10,
            ),

            // ปุ่มเพิ่มข้อมูล
            ElevatedButton(
              child: Text('Edit & Save'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue[400]),
                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                  textStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 15))),
              onPressed: () {
                updateTodo();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future updateTodo() async {
    var url = Uri.http("192.168.1.35:8000", "/api/delete-todolist/${_v1}");
    // var url = Uri.https("192.168.1.36:8000", "/api/post-todolist");
    Map<String, String> header = {"Content-Type": "application/json"};
    String jsondata =
        '{"title":"${todo_title.text}","detail":"${todo_detail.text}"}';
    var response = await http.put(url, headers: header, body: jsondata);
    print(response.body);
  }

  Future deleteTodo() async {
    var url = Uri.http("192.168.1.35:8000", "/api/delete-todolist/${_v1}");
    Map<String, String> header = {"Content-Type": "application/json"};
    var response = await http.delete(url, headers: header);
    print(response.body);
  }
}
