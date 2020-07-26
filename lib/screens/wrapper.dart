import 'package:flutter/material.dart';
import 'package:nehalcoffee/models/user.dart';
import 'package:nehalcoffee/screens/authenticate/authenticate.dart';
import 'package:nehalcoffee/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
