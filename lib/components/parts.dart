import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Parts extends StatelessWidget {
  String title = '';
  IconData icon;
  var func;
  Parts({super.key,required this.title,required this.icon,this.func});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: this.func,
        child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    this.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Icon(
                    this.icon,
                    size: 50,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          // width: 150,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(24),
            color: Colors.grey[700],
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                ),
              ],
          ),
        ),
      ),
    );
  }
}
