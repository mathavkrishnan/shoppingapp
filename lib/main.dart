import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled5/Auth.dart';
import 'package:untitled5/Homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDbRgau9VScpA1QeJe0VaGbyQesTEUQ0Jc",
      appId: "1:205308807668:android:cd46a7e6d55b8477bfd1a1",
      messagingSenderId: "205308807668",
      projectId: "buyfromus-619d6",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: Column(
          children: <Widget>[
            Text(
              "BuyMe",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            SizedBox(height: 20,),
            Text("Automatic identity verification which enable you to verify your identity",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 15
              ),
            ),
            SizedBox(height: 10,),
            Container(
                  height: MediaQuery.of(context).size.height/2,
                  child: Image.asset('assets/images/img1.jpg'),
            ),
            SizedBox(height: 10,),
            MaterialButton(
              minWidth: double.infinity,
              height:60,
              child: Text('Login',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white)),
              color: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
            SizedBox(height: 20,),
            MaterialButton(
              minWidth: double.infinity,
              child: Text('Sign up',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white)),
              color: Colors.black,
              height:60,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40) ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => signup()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}