import 'package:flutter/material.dart';
import 'package:progetto_wearable/screens/data.dart';
import 'package:progetto_wearable/screens/test_home.dart';
import 'package:progetto_wearable/screens/homepage.dart';
import 'package:progetto_wearable/screens/diary.dart';
import 'package:progetto_wearable/screens/login.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  static const route = '/homepage/';
  static const routename = 'HomePage';

  @override
  Widget build(BuildContext context) {
    print('HomePage built');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You already submitted today's entry",
              style: TextStyle(  
              fontSize: 18)),

            SizedBox(
              height: 100,
            ),
            ElevatedButton(
                onPressed: (){
                  //To do: navigation to self report pag
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  fixedSize: const Size(200, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
                child: Text(
                  'Self report',
                  style: TextStyle(  
                    fontSize: 25))),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: (){
                  //TO DO: navigation to contact page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  fixedSize: const Size(200, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
                child: Text(
                  'Ask for help',
                  style: TextStyle(  
                    fontSize: 25)),  
                    ),
          ],
        ),
      ),
    );
  } //build
} //HomePage