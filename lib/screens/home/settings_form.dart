import 'package:flutter/material.dart';
import 'package:nehalcoffee/models/user.dart';
import 'package:nehalcoffee/shared/constants.dart';
import 'package:nehalcoffee/services/database.dart';
import 'package:nehalcoffee/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(hintText: 'name'),
                    validator: (value) =>
                        value.isEmpty ? 'Please enter a name' : null,
                    onChanged: (value) {
                      setState(() {
                        _currentName = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentSugars ?? userData.sugars,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                            value: sugar, child: Text('$sugar sugars'));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _currentSugars = value;
                        });
                      }),
                  Slider(
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      min: 100,
                      max: 900,
                      divisions: 8,
                      onChanged: (value) {
                        setState(() {
                          _currentStrength = value.round();
                        });
                      }),
                  RaisedButton(
                    color: Colors.brown,
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength);

                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            Loading();
          }
        });
  }
}
