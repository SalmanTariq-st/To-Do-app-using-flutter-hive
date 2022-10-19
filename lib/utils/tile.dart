// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: camel_case_types
class tile extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var task;
  bool isCompleted = false;
  Function(bool?) onChanged;
  Function(BuildContext)? deleteTile;
  tile(
      {super.key,
      required this.task,
      required this.isCompleted,
      required this.onChanged,
      required this.deleteTile});

  // bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTile,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
              backgroundColor: Colors.red.shade300,
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(96, 137, 137, 138),
            
          ),
          padding: const EdgeInsets.all(15),
          child: Row(children: [
            Checkbox(
              value: isCompleted ? true : false,
              onChanged: onChanged,
              // checkColor: Colors.red,

              activeColor: Color.fromARGB(255, 35, 35, 35),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              task.toString(),
              style: isCompleted
                  ? TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      decoration: TextDecoration.lineThrough)
                  : TextStyle(color: Colors.white, fontSize: 20),
            ),
          ]),
        ),
      ),
    );
  }
}
