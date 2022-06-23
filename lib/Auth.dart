import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled5/Homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool Showspinner = false;
  late String email,pass;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        leading:
        IconButton( onPressed: (){
          Navigator.pop(context);
        },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
      ),
      body: ModalProgressHUD(
        inAsyncCall: Showspinner,
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
            child: Column(
              children: [
                SizedBox(height: 50,),
                Column(
                  children: <Widget>[
                    Text ("Login", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(height: 20,),
                    Text("Welcome back ! Login with your credentials",style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),),
                    SizedBox(height: 30,)
                  ],
                ),
                Column(
                  children: [
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("email",style:TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87
                    ),),
                    SizedBox(height: 5,),
                    TextField(
                      onChanged: (value){
                        email = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                      ),
                    ),
                    SizedBox(height: 30,)
                  ],
                ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("password",style:TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87
                ),),
                SizedBox(height: 5,),
                TextField(
                  onChanged: (value){
                    pass = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                    ),
                  ),
                ),
                SizedBox(height: 30,)
              ],
            ),
                  ],
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height:60,
                  onPressed: () async{
                    setState(() {
                      Showspinner = true;
                    });
                    try{
                      final user = await _auth.signInWithEmailAndPassword(email: email, password: pass);
                      if(user != null){
                        setState(() {
                          Showspinner = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => homepage()),
                        );
                      }
                    }
                    catch(e){

                    }
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => homepage()),
                    );*/
                  },
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child:
                  InkWell(
                    child:Text("Login",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white)),
                  ),
                ),
                SizedBox(height:10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont have an account?"),
                    InkWell(
                      child: Text("Sign Up",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18
                      ),),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => signup()),
                        );
                      },

                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late String email,password;
  bool spin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        leading:
        IconButton( onPressed: (){
          Navigator.pop(context);
        },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
      ),
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text ("Sign up", style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: 20,),
                      Text("Create an Account,Its free",style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),),
                      SizedBox(height: 30,)
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 40
                    ),
                    child: Column(
                      children: [
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("email",style:TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87
                        ),),
                        SizedBox(height: 5,),
                        TextField(
                          onChanged: (value){
                            email = value;
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                          ),
                        ),
                        SizedBox(height: 30,)
                      ],
                    ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("password",style:TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87
                          ),),
                          SizedBox(height: 5,),
                          TextField(
                            onChanged: (value){
                              password = value;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)
                              ),
                            ),
                          ),
                          SizedBox(height: 30,)
                        ],
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Confirm password",style:TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87
                        ),),
                        SizedBox(height: 5,),
                        TextField(
                          onChanged: (value){
                            password = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                          ),
                        ),
                        SizedBox(height: 30,)
                      ],
                    )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 3,left: 3),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height:60,
                        onPressed: ()async{
                          _firestore.collection('Users').add(
                              {
                                'Name':email,
                                'Password':password,
                                'Mobileno':"",
                                'Address':""
                              }
                          );
                            try{
                              final newuser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                              setState(() {
                                spin = true;
                              });
                              if(newuser!=null){
                                setState(() {
                                  spin = false;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => homepage()),
                                );
                              }
                              else{
                                setState(() {
                                  spin = false;
                                });
                              }
                            }
                            catch(e){
                            }
                          },
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: Text("Sign Up",style: TextStyle(
                            fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white
                        ),),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      InkWell(
                        child: Text("Login",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),),
                        onTap: (){},
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );*/
                      )
                    ],
                  )
                ],

              ),
            ],
          ),
        ),
      ),
    );
  }
}


