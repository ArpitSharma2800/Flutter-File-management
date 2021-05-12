import 'package:flutter/material.dart';

class Name extends StatelessWidget {
  const Name({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Arpit',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 16.0),
            )
          ],
        ),
      ),
    );
  }
}
