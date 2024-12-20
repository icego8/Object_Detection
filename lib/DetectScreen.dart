import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class detectScreen extends StatefulWidget{
  @override
  State<detectScreen> createState() => _detectScreenState();
}

class _detectScreenState extends State<detectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Detection"),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Choose Camera or Gallery", style: TextStyle(color: Colors.blue),),
            SizedBox(
              height: 150,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text("for Camera"),
                    IconButton(
                        onPressed: (){

                        },
                        icon: FaIcon(CupertinoIcons.camera,)
                    ),
                  ],
                ),
                  Column(
                  children: [
                    Text("for Gallery"),
                    IconButton(
                    onPressed: (){},
                    icon: FaIcon(CupertinoIcons.camera,)
                    ),
                  ],
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}