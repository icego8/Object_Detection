import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:object_detect3/DetectScreen.dart';

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Text("Object Detection", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.blue),),
            ElevatedButton(
                onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => detectScreen(),));
                },
                child: Text("Start", style: TextStyle(color: Colors.blue),))
          ],
        ),
      ),
    );
  }

}