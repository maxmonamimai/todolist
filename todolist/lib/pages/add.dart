import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:todolist/pages/todolist.dart';

class AddPage extends StatefulWidget {
  // const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add List"),),
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
            SizedBox(height: 10,),
            TextField(
                    controller: todo_detail,
                    decoration: InputDecoration(
                        labelText: 'Detail', border: OutlineInputBorder()),
                    minLines: 4,
                    maxLines: 8,
                  ),
            SizedBox(height: 10,),

            // ปุ่มเพิ่มข้อมูล
            ElevatedButton(
                    child: Text('save'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue[400]),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.all(20)),
                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))
                            ),
                    onPressed: () {
                      postTodo();
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Future postTodo() async {
    var url = Uri.http("192.168.1.35:8000", "/api/post-todolist");
    // var url = Uri.https("192.168.1.36:8000", "/api/post-todolist");
    Map<String, String> header = {
      "Content-Type":"application/json"
      };
    String jsondata = '{"title":"${todo_title.text}","detail":"${todo_detail.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print(response.body);
    Navigator.push(context, MaterialPageRoute(builder: (context) => TodoList()));
  }

}