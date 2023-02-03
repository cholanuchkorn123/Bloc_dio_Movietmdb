 import 'package:flutter/material.dart';
 Future<dynamic> Showdialog(BuildContext context, String word) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.purple.shade200,
              content: Text(
                word,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ));
  }