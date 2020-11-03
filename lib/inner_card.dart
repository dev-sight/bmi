
import 'package:flutter/material.dart';


class InnerCard extends StatelessWidget {
  InnerCard({@required this.icon, @required this.label});

  final IconData icon ;
  final String label ;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80.0,
          color: Colors.white,
        ) ,
        SizedBox(
          height: 15.0,
        ),
        Text(label,
          style: TextStyle(
            fontSize: 18.0 ,
            color: Color(0xFF8D8E98),
          ),
        ),
      ],
    );
  }
}