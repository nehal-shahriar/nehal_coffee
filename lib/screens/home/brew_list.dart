import 'package:flutter/material.dart';
import 'package:nehalcoffee/models/brew.dart';
import 'package:provider/provider.dart';
import 'package:nehalcoffee/screens/home/brewtile.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];

    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index) {
          return BrewTile(brew: brews[index]);
        });
    //print(brews.documents);
  }
}
