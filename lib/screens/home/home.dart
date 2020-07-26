import 'package:flutter/material.dart';
import 'package:nehalcoffee/screens/home/brew_list.dart';
import 'package:nehalcoffee/screens/home/settings_form.dart';
import 'package:nehalcoffee/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:nehalcoffee/services/database.dart';
import 'package:nehalcoffee/models/brew.dart';

class Home extends StatelessWidget {
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(30),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.brown,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _authService.signOut();
              },
              label: Text('Logout'),
              icon: Icon(Icons.person),
            ),
            FlatButton.icon(
                onPressed: () {
                  _showSettingsPanel();
                },
                icon: Icon(Icons.settings),
                label: Text('settings'))
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BrewList()),
      ),
    );
  }
}
