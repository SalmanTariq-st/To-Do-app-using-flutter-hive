// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, avoid_unnecessary_containers, sort_child_properties_last, file_names, sized_box_for_whitespace, unused_field, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes/storage/noteData.dart';
import 'package:notes/utils/tile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _box = Hive.box('note');
  noteData db = noteData();
  TextEditingController text = TextEditingController();
  // List notes = [];
  bool isEmpty = true;
  @override
  void initState() {
    if (_box.get("note") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

  void onChanged(int index) {
    setState(() {
      db.notes[index][1] = !db.notes[index][1];
      db.updateDatabase();
    });
  }

  void deleteIndex(int index) {
    setState(() {
      db.notes.removeAt(index);
      db.updateDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 59, 59, 59),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(96, 137, 137, 138),
        title: const Text(
          'Todo list',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        elevation: 10,
      ),
      body:
          // isEmpty
          //     ? Center(
          //         child: Text('No notes'),
          //       )
          //     :
          ListView.builder(
        itemCount: db.notes.length,
        itemBuilder: (context, index) {
          return tile(
            task: db.notes[index][0],
            isCompleted: db.notes[index][1],
            onChanged: (p0) => onChanged(index),
            deleteTile: (context) => deleteIndex(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                content: Container(
                  height: 120,
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      TextField(
                        controller: text,
                        decoration: InputDecoration(hintText: 'Type here'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          MaterialButton(
                            onPressed: () {
                              db.notes
                                  .add([text.text.trim().toString(), false]);
                              setState(() {
                                text.clear();
                                Navigator.of(context).pop();
                                db.updateDatabase();
                              });
                            },
                            color: Color.fromARGB(255, 76, 76, 76),
                            textColor: Colors.white,
                            child: Text('Save'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                            color: Color.fromARGB(255, 76, 76, 76),
                            child: Text('Cancel'),
                            textColor: Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
