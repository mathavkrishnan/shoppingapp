import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled5/Auth.dart';
import 'package:untitled5/Homepage.dart';
import 'package:untitled5/Person.dart';
import 'package:firebase_auth/firebase_auth.dart';

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  @override
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Product detail",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        actionsIconTheme: IconThemeData(
            size: 30.0,
            color: Colors.black,
            opacity: 10.0
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        leading: IconButton( onPressed: (){
          Navigator.pop(context);
        },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
      ),

      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => homepage()),
                );
              },
              icon: const Icon(
                Icons.home,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => cart()),
                );
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profile()),
                );
              },
              icon: const Icon(
                Icons.person,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
      ),


      body: Container(
        child: Container(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('cart').snapshots(),
                  builder: (context,AsyncSnapshot snapshot) {
                    final item = snapshot.requireData.docs;
                    final List<Container> first = [];
                    int total = 0;
                    if(snapshot.hasData){
                      for(var j in item){
                        final itemname = j.get('Name');
                        final itemcartquantity = j.get('CartQuantity');
                        final itemimage = j.get('Image');
                        final itemprice = j.get('Price');
                        final itemquantity = j.get('Quantity');
                        final itemuser = j.get('UserEmail');
                        final user = _auth.currentUser;
                        String authuser = " ";
                        if(user != null){
                          authuser = user.email!;
                        }
                        final widg = Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Image.asset("assets/images/$itemimage.jpg",
                                    width: 150,
                                    height: 150,
                                    fit:BoxFit.fill
                                ),
                                SizedBox(width: 50,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("$itemname"),
                                    Text("$itemquantity"),
                                    Text("$itemprice"),
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.add), onPressed: () {
                                          _firestore.collection('cart').where('UserEmail', isEqualTo: authuser).where('Name', isEqualTo: itemname).get().then((querySnapshot) {
                                            querySnapshot.docs.forEach((documentSnapshot) {
                                              documentSnapshot.reference.update({
                                                'CartQuantity':(int.parse(itemcartquantity)+1).toString(),
                                                'Name':itemname,
                                                'Price':itemprice,
                                                'Quantity':itemquantity,
                                                'UserEmail':authuser,
                                                'Image':itemimage,
                                              });
                                            });
                                          });
                                        },
                                        ),
                                        Text("$itemcartquantity"),
                                        IconButton(
                                          icon: Icon(Icons.remove), onPressed: () {
                                          if(itemcartquantity == "0"){
                                            _firestore.collection('cart').where('UserEmail', isEqualTo: authuser).where('Name', isEqualTo: itemname).get().then((querySnapshot) {
                                              querySnapshot.docs.forEach((documentSnapshot) {
                                                documentSnapshot.reference.delete();
                                              });
                                            });
                                          }
                                          else{
                                            _firestore.collection('cart').where('UserEmail', isEqualTo: authuser).where('Name', isEqualTo: itemname).get().then((querySnapshot) {
                                              querySnapshot.docs.forEach((documentSnapshot) {
                                                documentSnapshot.reference.update({
                                                  'CartQuantity':(int.parse(itemcartquantity)-1).toString(),
                                                  'Name':itemname,
                                                  'Price':itemprice,
                                                  'Quantity':itemquantity,
                                                  'UserEmail':authuser,
                                                  'Image':itemimage,
                                                });
                                              });
                                            });
                                          }
                                        },
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ]
                          ),
                        );
                        if(itemuser == authuser){
                          total += int.parse(itemprice) * int.parse(itemcartquantity);
                          first.add(widg);
                        }
                      }
                    }
                    return Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("SubTotal"),
                                      Text(("$total")),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                                  child: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Total"),
                                      Text((total+10).toString()),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                                  child: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: MaterialButton(
                                    minWidth: double.infinity,
                                    height:60,
                                    onPressed: () {  },
                                    child: Text(
                                      "Pay $total",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40)
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: first
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 30,),
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

