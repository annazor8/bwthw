import 'package:flutter/material.dart';
import 'package:progetto_wearable/screens/home.dart';
import 'package:progetto_wearable/screens/login.dart';
import 'package:progetto_wearable/utils/mydrawer.dart';
import 'package:progetto_wearable/utils/myappbar.dart';
import 'package:progetto_wearable/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progetto_wearable/repository/databaseRepository.dart';
import 'package:provider/provider.dart';
import 'package:progetto_wearable/database/entities/diaryentry.dart';
import 'package:progetto_wearable/utils/funcs.dart';

class Diary extends StatefulWidget {
  const Diary({Key? key}) : super(key: key);

  static const route = '/diary/';
  static const routename = 'Diary';

  @override
  State<Diary> createState() => _DiaryState();
}
class _DiaryState extends State<Diary>  {

  //Variabili ridondanti, prima della consegna potremo toglierle
  bool _happyPressed = false;
  bool _neutralPressed = false;
  bool _sadPressed = false;

  String? _entryMood = null;
  String? _entryText = null;

  final snackBarText = const SnackBar(
    content: Text('You should write something'),
  );
  final snackBarMood = const SnackBar(
    content: Text('You should pick a mood'),
  );


  @override
  Widget build(BuildContext context) {
    print('Diary built');
    return Scaffold(
      appBar: MyAppbar(),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "How do you feel today?",
              style: TextStyle(  
              fontSize: 18)),
              SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 60,
                  icon: Icon(
                    Icons.sentiment_very_satisfied,
                    color: _happyPressed ? Colors.green : Colors.black,
                    ),
                  onPressed: () {
                    setState((){
                          _happyPressed = true;
                          _neutralPressed = false;
                          _sadPressed = false;
                          _entryMood = 'Happy';
                        });
                  },
                  ),
                IconButton(
                  iconSize: 60,
                  icon: Icon(
                    Icons.sentiment_neutral,
                    color: _neutralPressed ? Colors.orange : Colors.black,
                    ),
                  onPressed: () {
                    setState((){
                          _happyPressed = false;
                          _neutralPressed = true;
                          _sadPressed = false;
                          _entryMood = 'Neutral';
                        });
                  },
                  ),                  
                IconButton(
                  iconSize: 60,
                  icon: Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: _sadPressed ? Colors.red : Colors.black,
                    ),
                  onPressed: () {
                    setState((){
                          _happyPressed = false;
                          _neutralPressed = false;
                          _sadPressed = true;
                          _entryMood = 'Sad';
                        });
                  },
                  ),
          ]),
            SizedBox(
              height: 100,
            ),
            Container(
              width: 300.0,
              child:
                TextField(
                  maxLines: 4,
                  onChanged: (text) {  
                    _entryText = text;  
                  },
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'Enter your text',
                    hintStyle: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[400],
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    suffixIcon:IconButton(
                      icon: Icon(Icons.clear),
                      color: Colors.grey[400],
                      onPressed: (){
                      //TO DO: cancellazione del contenuto text box
                      }),
                    ),
                  )),
          
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: (){
                  _entryCheck(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: const Size(200, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
                child: Text(
                  'Submit',
                  style: TextStyle(  
                    fontSize: 25)),  
                    ),
          ],
        ),
      ),
    );
  } //build

  
  void _entryCheck(BuildContext context) async{
  
     if(_entryMood == null) { //Se non c'è il mood appare la snackbar appropriata
      ScaffoldMessenger.of(context).showSnackBar(snackBarMood);

     }else if(_entryText == '' || _entryText == null){ //Se non c'è testo appare la snackbar appropriata
      ScaffoldMessenger.of(context).showSnackBar(snackBarText);
    
    }else{ //Se c'è testo non appare la snackbar ed attribuisco il testo alla entry di oggi 
    await Provider.of<DatabaseRepository>(context, listen: false)
                .insertDiaryentry(Diaryentry(getTodayDate(),_entryText!, _entryMood!));
    
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Homepage()), (route) => false);
    
    //Diario con uso sp, deprecated
    //SharedPreferences sp = await SharedPreferences.getInstance();
    //sp.setString(sp.getString('lastEntryDate')!, _entryText!);
    //sp.setString(sp.getString('lastEntryDate')!+'M', _entryMood!);
    }
  }
} //HomePage

/*
DA METTERE SE CI SONO PROBLEMI

//Check ulteriore nel caso l'utente finisce accidentalmente nel 
  void _checkLegitimacy(context)async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if(sp.getBool('firstEntryOfToday')!){
      sp.setBool('firstEntryOfToday', false);
    }else{
      print('UNINTENDED ACCESS IN THE DIARY PAGE!!!');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }
  }
  */


