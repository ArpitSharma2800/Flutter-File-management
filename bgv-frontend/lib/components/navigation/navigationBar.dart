import 'package:bgv/components/navigation/src/name.dart';
import 'package:bgv/components/navigation/src/navbar.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  List<bool> selected;
  NavigationBar(this.selected);

  @override
  _NavigationBarState createState() => _NavigationBarState(this.selected);
}

class _NavigationBarState extends State<NavigationBar> {
  List<bool> selected;
  _NavigationBarState(this.selected);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: 100,
          color: Color(0xff333951),
          child: Stack(
            children: [
              // Name(),
              Align(alignment: Alignment.center, child: NavBar(selected))
            ],
          ),
        ),
      ),
    );
  }
}
