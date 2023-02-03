import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Status {
  Widget loading(context) {
    return Center(
        child: Platform.isIOS
            ? CupertinoActivityIndicator()
            : CircularProgressIndicator());
  }

  Widget falied(context) {
    return Center(child: Text('Loading Failed'));
  }
}
