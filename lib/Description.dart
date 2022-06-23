import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled5/Auth.dart';
import 'package:untitled5/Homepage.dart';

class description extends StatelessWidget {
  description(String name,String itemdescriptions, String likes, String price,String images,String authuser,String quantity){
    this.name = name;
    this.itemdescriptions = itemdescriptions;
    this.likes = likes;
    this.price = price;
    this.images = images;
    this.images2 = images+(1).toString();
    this.images3 = images+(2).toString();
    this.authuser = authuser;
    this.quantity = quantity;
  }
  String name="",itemdescriptions="",likes="",price="",images="",images2="",images3="",authuser="",quantity="";
  final _firestore = FirebaseFirestore.instance;
  var opt = ["","1","2"];
  @override
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
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("₹$price",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 23),),
            TextButton(
                onPressed: () {
                  _firestore.collection('cart').add(
                    {
                      'CartQuantity':"1",
                      'Name':name,
                      'Price':price,
                      'Quantity':quantity,
                      'UserEmail':authuser,
                      'Image':images
                    }
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add,color: Colors.black,),
                    Text("Add to cart",style: TextStyle(color: Colors.black,fontSize: 15),)
                  ],
                )
            )
          ],
        ),
      ),


      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: opt.map((country){
                  return Container(
                    padding: EdgeInsets.all(50),
                    child: Expanded(
                      child: Image.asset("assets/images/$images$country.jpg",
                          width: 280,
                          height: 400,
                          fit:BoxFit.fill
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Text(
              "$name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20
              ),
            ),
         SizedBox(height: 15,),
         Text(
          "Information",
          style: TextStyle(
              color: Colors.black,
              fontSize: 18
          ),
        ),
            Container(
                padding: EdgeInsets.all(20),
                child: Text("$itemdescriptions",style: TextStyle(fontSize: 15,color: Colors.black),)),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Icons.favorite,color: Colors.pinkAccent,),
                  Text(
                    "$likes"
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}